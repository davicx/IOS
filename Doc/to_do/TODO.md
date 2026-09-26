# Kite App – To Do List

Generated from codebase review. Grouped by area.

---

## 1. Item purchase flow (Wishlist)

- [ ] **Wire Purchase to API**  
  `ItemPurchaseViewController` currently only prints selected users and dismisses. Pass the selected usernames and the post into the purchase flow: give the VC a `post: Post?` (or postID), then on Purchase tap call `PostLogic.purchaseItem(post:groupID:purchasedViewers:)` with `Array(selectedUsernames)`, show spinner, dismiss on success, and rely on `.postUpdated` for UI refresh.

- [ ] **PostLogic.purchaseItem use real viewers**  
  In `PostLogic.swift`, `purchaseItem(post:groupID:)` still uses hardcoded `showPurchased = ["frodo", "bilbo"]`. Change the signature to accept `purchasedViewers: [String]` (from ItemPurchaseViewController) and pass that to the API and into `markItemPurchased(..., purchasedViewers:)`.

- [ ] **Pass post into ItemPurchaseViewController**  
  When presenting the sheet from `ItemCellLayout`, set `itemPurchaseVC.post = post` (add `var post: Post?` on the VC) so the VC can call PostLogic with the correct post and selected viewers.

- [ ] **Only show purchased section to users with permission**  
  You added `currentUserOwnsGroup` and the temporary permission debug view. When ready: pass `currentUserOwnsGroup` into `ItemCellLayout` and use it (with `post.purchasedViewers` and current user) to show/hide the “purchased” UI only for users who are allowed to see it.

---

## 2. ItemCellLayout / item post UI

- [ ] **Remove temporary permission debug view**  
  Remove `purchasedPermissionDebugView`, `purchasedPermissionDebugLabel`, `setupPurchasedPermissionDebugView()`, and the debug text in `apply(post:)` once permission logic is in place and you no longer need the on-screen debug.

- [ ] **Item header**  
  `//TO DO: Add header subviews (group image, group name, user, etc.)` in `ItemCellLayout`.

- [ ] **Replace temporary/placeholder colors**  
  Several `//TO DO: Replace with Style colors for production` in ItemCellLayout (header, body, footer, etc.). Switch to your app’s Style colors.

- [ ] **Item description placeholder**  
  Default text like “Item description goes here…” is still used in at least one path; ensure real copy comes from `post` everywhere or use a proper placeholder pattern.

---

## 3. Profile

- [ ] **Edit Profile navigation**  
  `editProfileButton()` only prints “Edit Profile”. Implement navigation to `EditProfileViewController` (e.g. from Profile storyboard), pass current user data, and set delegate for profile updates (same pattern as in your commented reference code).

- [ ] **Posts count tap (optional)**  
  Profile shows Posts / Groups / Friends counts. Only Friends is wired (navigates to FriendsViewController). If you want, add tap on Posts (e.g. to a “My posts” screen) and on Groups (e.g. to groups list or a filtered view).

- [ ] **Profile doc / naming**  
  Consider renaming confusing names mentioned in comments (e.g. `userRightLeftView` → `friendsContainerView`, `userMiddleLeftView` → `groupsContainerView`) and improving placeholder handling (e.g. UILabel placeholder for biography) when you touch those areas.

---

## 4. PostLogic / PostDataController

- [ ] **Home feed**  
  `PostDataController.getHomeFeedPosts()` is “for now, returns posts from group 72”. Replace with real home feed when backend is ready.

- [ ] **“Add Kite later”**  
  Comment in `PostLogic` for Kite-specific behavior; implement when you add that feature.

---

## 5. Other screens / flows

- [ ] **FriendListViewController**  
  Comment: “Later: Fetch friendListArray via API” when viewing another user’s friend list.

- [ ] **Discover**  
  Search uses placeholder results and “for later filtering”; wire to real search when ready.

- [ ] **Comment count**  
  At least one place still has “Comment count - set to 0 for now”; hook to real data when available.

---

## 6. Cleanup / polish

- [ ] **Temporary colors and debug UI**  
  Remove or replace: CommentCellLayout/CommentCell `menuButton` red tint and green debug background; GroupItemFriendCell “temporary label”; any other temp colors used for layout debugging.

- [ ] **Duplicate ItemPurchaseUserCell**  
  You have both `Item/ItemPurchaseUserCell.swift` and `Item/cells/ItemPurchaseUserCell.swift`; remove the duplicate and keep one so the table and storyboard/target stay consistent.

- [ ] **Error handling**  
  Item purchase flow (and other async flows) could show a brief error message or retry when the API fails instead of only logging; consider a small shared error-toast or alert pattern.

---

## 7. Friend actions — cache-driven UI refresh

Full checklist: **`Kite/Docs/to_do.md`**

- [ ] **Phase 1:** `GroupMembersViewController` — observe `.friendsUpdated`, `syncMembersFromCache()`, stop manual row patching
- [ ] **Phase 2:** `FriendListViewController` — same pattern (add friend only today)
- [ ] **Phase 3:** Review `FriendsViewController` for consistency (reference impl; may keep API `fetchFriends()`)

---

## Summary (priority order)

1. **Item purchase end-to-end:** Pass post + selected users into ItemPurchaseViewController → PostLogic with `purchasedViewers` → remove hardcoded list.
2. **Remove ItemCellLayout permission debug** once real permission-based visibility is done.
3. **Profile Edit:** Implement Edit Profile navigation and delegate.
4. **ItemCellLayout:** Header subviews, Style colors, and description placeholder.
5. **General:** Clean up temporary UI/debug code, resolve duplicate cell file, then optional taps and home feed.
