# Friend Actions Cleanup Checklist

Small cleanup of the friend action flow. Keep the current architecture — no new layers.

## Goal

Perform a small cleanup of the friend action flow while keeping the current architecture.

### Principles

- No new architecture (no Runner, Coordinator, Manager, ViewModel, etc.)
- Keep `UserLogic` responsible for friend actions
- Keep `UsersDataController` as the source of truth
- ViewControllers should react to cache updates instead of manually patching local arrays
- Minimize code changes

### Target flow

```
User taps button
    ↓
UserLogic (API + update cache)
    ↓
UsersDataController
    ↓
.friendsUpdated
    ↓
ViewController refreshes from cache
```

---

## Phase 1 — GroupMembersViewController (Highest Priority)

**File:** `App/Main/Groups/GroupMembers/GroupMembersViewController.swift`

### Observe friend updates

- [ ] Register for `.friendsUpdated` in `viewDidLoad()`
- [ ] Remove observer in `deinit`

### Refresh from cache

Add:

- [ ] `handleFriendsUpdated()`
- [ ] `syncMembersFromCache()`

`syncMembersFromCache()` should:

- Loop through `groupMembers`
- Replace each user with `UsersDataController.shared.getUser(username:)` when available
- If `getUser` returns `nil`, keep the existing member (do not drop rows)
- Reload the table view

In `handleFriendsUpdated()`:

- [ ] Clear loading state for finished actions (`loadingUsernames.remove`, affected cells `setLoading(false)`) so spinners do not stick after reload

### Simplify friend actions

Review:

- [ ] `handleFriendAction(for:at:)`
- [ ] `handleDeclineInvite(for:at:)`

**Keep:**

- Confirmation alerts
- Loading indicators
- Timeout handling (`withTimeout`)
- `UserLogic` calls
- Error alerts (`showErrorAlert`)

**Remove on success:**

- `groupMembers[index] = updatedUser`
- `cell.configure(with: updatedUser)`
- `reloadRows(...)` for friend-action success paths

Let notification + cache sync refresh the UI instead.

### Cell callbacks

Review `cellForRowAt`.

Optional:

- [ ] Extract `configureCellActions(for:cell:)` if it improves readability (mirror `FriendsViewController`)

---

## Phase 2 — FriendListViewController

**File:** `App/Main/Profile/Friends/FriendListViewController.swift`

**Scope note:** This screen currently only wires **add friend** (`addFriendTapped`). No cancel/remove actions here unless the list later shows other friendship states.

### Observe updates

- [ ] Register for `.friendsUpdated` in `viewDidLoad()`
- [ ] Remove observer in `deinit`
- [ ] Add `handleFriendsUpdated()`

### Refresh from cache

- [ ] Sync `friendListArray` using `UsersDataController.getUser(username:)` (keep existing row if nil)
- [ ] Reload table view

### Simplify actions

Review:

- [ ] `addFriendTapped` closure in `cellForRowAt`

**Keep:**

- Loading (`loadingUsernames`, `cell.setLoading`)
- `UserLogic.shared.sendFriendRequest`
- Error handling (`showErrorAlert`)

**Remove on success:**

- `friendListArray[index] = updatedUser`
- `cell.configure(with: updatedUser)`

Let notifications refresh the UI.

---

## Phase 3 — FriendsViewController Review

**File:** `App/Main/Profile/Friends/FriendsViewController.swift`

Reference implementation — already the cleanest pattern.

- [ ] Verify all friend actions follow: VC → `UserLogic` → `UsersDataController` → notification → refresh UI
- [ ] No major changes expected
- [ ] **Intentional difference:** `handleFriendsUpdated()` calls `fetchFriends()` (API refetch). Group Members / Friend List can use lighter **cache-only** sync via `syncMembersFromCache()` / equivalent

Relevant functions to review (no rewrite required):

- `handleFriendsUpdated()`
- `cancelFriendAPI(for:)`, `removeFriendAPI(for:)`, `acceptInviteAPI(for:)`, `declineInviteAPI(for:)`
- `configureCellActions(for:cell:)`

---

## Phase 4 — Optional Notification Improvement

Only if full table reloads become expensive.

**File:** `Functions/Controllers/UsersDataController.swift`

- [ ] Include changed usernames in notification `userInfo`, e.g. `["usernames": ["sam"]]`
- [ ] ViewControllers reload only affected rows instead of whole table

Post from:

- `updateUserFriendStatus(user:)`
- `updateUserFriendStatusToNotFriends(username:)`

**Skip Phase 4** until Phases 1–2 are done and reload cost is noticeable.

---

## Phase 5 — Optional Generic Loading Helper (Last)

Only if loading + timeout + error copy-paste becomes annoying (~10 lines × many screens).

- [ ] Generic helper (e.g. `LoadingFunctions.performLoadingTask(on:block:)`) — **not** friend-specific
- [ ] No `FriendActionRunner`, `FriendCoordinator`, etc.

Skip unless duplication actually bothers you.

---

## Files Expected to Change

### Primary (Phases 1–2)

- [ ] `App/Main/Groups/GroupMembers/GroupMembersViewController.swift`
- [ ] `App/Main/Profile/Friends/FriendListViewController.swift`

### Small review (Phase 3)

- [ ] `App/Main/Profile/Friends/FriendsViewController.swift`

### Optional (Phase 4)

- [ ] `Functions/Controllers/UsersDataController.swift`

---

## Files That Should Not Change

These already have the correct responsibilities:

- [ ] `Functions/Posts/UserLogic.swift` — `sendFriendRequest`, `cancelRequest`, `remove`, `accept`, `decline`
- [ ] `App/Main/Profile/Friends/TableCells/FriendTableViewCell.swift`
- [ ] `App/Main/Profile/Friends/TableCells/FriendTableUserCell.swift` (`YourFriendsTableViewCell`)
- [ ] `Style/Buttons.swift`

---

## Already Done (No Work)

- [x] `YourFriendsTableViewCell` — multi-button layout + `Buttons.*`
- [x] `FriendTableViewCell` — same pattern + separate callbacks
- [x] `UserLogic` + `UsersDataController` cache + `.friendsUpdated` on friend status updates

---

## Success Criteria

- [ ] Friend actions update `UsersDataController` once (via `UserLogic`)
- [ ] Every affected screen refreshes from the shared cache on `.friendsUpdated`
- [ ] No manual array patching after successful friend actions
- [ ] No duplicate business logic across ViewControllers
- [ ] No new architecture or abstraction layers added
- [ ] Existing layer responsibilities unchanged (`UserLogic` boring, VC wires UI only)

---

## Suggested Order

1. **Phase 1 only** — meaningful cleanup on Group Members
2. **Phase 2** — Friend List same pattern
3. **Phase 3** — consistency review
4. **Phase 4 / 5** — only if needed later
