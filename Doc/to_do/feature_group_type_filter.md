# Kite — Filter Groups by `group_type`

## Goal

Keep **Kite** and **Wishlist** on one DB / one codebase, but make the groups list (and related fetches) respect `group_type` so each mode only sees its own groups.

```text
Kite mode     → only groups where group_type = 'kite'
Wishlist mode → only groups where group_type = 'wishlist'
```

**Status:** Plan (not started)  
**Prerequisite:** Dev DB cleaned (done) — see Canonical data below.

**Related:** [Kite.swift mode checklist](../Functions/Docs/Kite.swift) · Home fetch/read group ID mismatch (fetch 80 / read 70) · **[feature_enforce_content_by_group_type.md](./feature_enforce_content_by_group_type.md)** (wishlist→items, kite→posts — API enforce)

---

## Canonical data (dev DB — already cleaned)

| Group ID | `group_type` | Name            | Role              |
| -------- | ------------ | --------------- | ----------------- |
| **70**   | `kite`       | Davey Kite      | Davey’s Kite home |
| **80**   | `wishlist`   | Davey Wishlist  | Davey’s list home |
| **82**   | `wishlist`   | Sam Wishlist    | Sam’s list        |

Rules after cleanup:

- Kite content → `posts` with `master_site = 'kite'`, `post_type` in `photo` / `text`, inside a `kite` group
- Wishlist content → `posts` with `master_site = 'wishlist'`, `post_type = 'item'` (+ `items` row), inside a `wishlist` group

Soft-deleted leftovers (722, 723, 724, 725, 72) should stay out of lists via `group_deleted = 0`.

---

## Current behavior (why this is needed)

### API — now returns `groupType`; filter still TODO

`GET /groups/user/:userName` includes `groupType` per group (from `groups.group_type`).

Still does **not** filter by type — clients get all non-deleted memberships and can display/filter locally until `?groupType=` is added.

---

## Target behavior

```text
Wishlist build / Wishlist blocks active
  → groups list = only wishlist groups (80, 82, …)
  → home feed   = items for canonical wishlist group (80 for Davey)
  → create group → group_type = 'wishlist'

Kite build / Kite blocks active
  → groups list = only kite groups (70, …)
  → home feed   = posts for canonical kite group (70 for Davey)
  → create group → group_type = 'kite'
```

Mode flip stays comment/uncomment `//KITE` / `//WISHLIST` for now (see `Kite.swift`). Filtering should key off the **same mode**, not ad-hoc group IDs forever — but hardcoding 70/80 for home is OK until a “default group” exists.

---

## Plan

### Phase 1 — API: return and filter `group_type`

**Files (API):**

- `application/functions/classes/Group.js` — `getGroupsUserIsIn`, group detail queries used by list
- `application/logic/groups.js` — `getGroups` / `getUserGroups`
- `application/routes/groupRoute.js` — route shape

**Do:**

1. ~~Include `group_type` (camelCase `groupType` in JSON) on group list/detail responses.~~ **Done** (`getGroupInformation` + `getGroups`; create responses too).
2. Add optional filter on the existing user-groups endpoint, e.g.:

   ```text
   GET /groups/user/:userName?groupType=kite
   GET /groups/user/:userName?groupType=wishlist
   ```

   When `groupType` is omitted, keep current behavior (all non-deleted memberships) for backward compatibility.

3. SQL: add `AND shareshare.groups.group_type = ?` when the query param is present (whitelist values: `kite`, `wishlist` only).
4. Create group: ensure client-sent `groupType` is persisted (already mostly works); do not default Wishlist creates to `kite` from the server if the client sends `wishlist`.

**Out of scope for this phase:** separate `/wishlist/...` route tree; items/posts endpoint `post_type` hardening (nice follow-up).

**Verify:**

```sql
-- Davey kite-only memberships
-- API with ?groupType=kite  → includes 70, excludes 80/82
-- API with ?groupType=wishlist → includes 80 (and 82 if member), excludes 70
```

---

### Phase 2 — iOS models + API client

**Files:**

- `API/Models/Groups/GroupModel.swift` — add `groupType: String`
- `API/GroupsAPI.swift` — `getGroupsAPI(for:groupType:)`
- Decode path / any `GroupsResponseModel` mapping
- `Functions/Controllers/GroupDataController.swift` — pass type into fetch; optionally keep typed caches

**Do:**

1. Add `groupType` to `GroupModel` (and mapping from API).
2. Extend `getGroupsAPI` to pass `groupType` query param.
3. `GroupDataController.getGroups` accepts mode type (or reads a small mode constant) and requests only that type.
4. Create group: Wishlist path sends `groupType: "wishlist"`; Kite path sends `"kite"` (fix hardcodes in create VCs / `GroupsAPI` if any force `"kite"`).

---

### Phase 3 — Wire mode switch surfaces

**Files:**

- `App/Main/GroupsViewController.swift` — fetch with active mode’s `groupType`
- `Functions/Docs/Kite.swift` — checklist note for groups fetch type
- Create-group entry points used by Lists vs Events
- Home (related cleanup, same effort window):

  - Wishlist: `fetchWishlistItems(80)` **and** `getHomeFeedPosts()` must both use **80**
  - Kite: `fetchKitePosts(70)` **and** `getHomeFeedPosts()` must both use **70**

**Do:**

1. Groups tab fetch uses `groupType` matching `//KITE` / `//WISHLIST` active mode.
2. Align Home write/read group IDs (known bug: fetch 80 / display 70).
3. Optional: when opening a group, assert `group.groupType` matches mode (avoid opening a kite event from Wishlist UI).

---

### Phase 4 — Follow-ups (optional, separate)

- Items API: `GET /items/group/:id` should require `post_type = 'item'` (and ideally group is `wishlist`).
- Posts API: `GET /posts/group/:id` should exclude `item` rows (and ideally group is `kite`).
- Server-side reject creating `item` posts in `kite` groups and photo/text in `wishlist` groups.
- Default / “home” group per user per type instead of hardcoding 70/80.

---

## Suggested implementation order

| Step | Work                         | Depends on |
| ---- | ---------------------------- | ---------- |
| 1    | API return + filter `groupType` | DB clean ✓ |
| 2    | iOS `GroupModel` + `GroupsAPI` | Step 1     |
| 3    | `GroupDataController` + Groups VC | Step 2 |
| 4    | Create-group `groupType` fix | Step 1–2   |
| 5    | Home 70/80 read/write align  | Independent quick fix |
| 6    | (Later) posts/items type filters | After 1–5 |

---

## Acceptance checks

- [ ] Wishlist mode groups list: only `group_type = wishlist` (Davey sees 80; not 70)
- [ ] Kite mode groups list: only `group_type = kite` (Davey sees 70; not 80/82)
- [ ] Creating a list in Wishlist persists `group_type = 'wishlist'`
- [ ] Creating an event in Kite persists `group_type = 'kite'`
- [ ] Soft-deleted groups still hidden
- [ ] Home Wishlist shows only the 5 items in group 80 (after Home ID fix)
- [ ] Home Kite shows only photo/text in group 70

---

## Notes

- Prefer **query param on existing route** over a second parallel groups API so the mode switch stays thin.
- Do not rename/reuse primary keys again; create new groups with the correct `group_type` going forward.
- `post_to` is usually the group id string; do not assume it always is (e.g. post 841 → `frodo`).
