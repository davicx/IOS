# Feature: Comments on Individual Post

**Status:** Step 3 done — owner-only Delete  
**Scope:** `IOS/Kite/Kite` (comments UI + delete flow); API soft-delete added  
**Screen:** `IndividualPostViewController` → `CommentCell` rows under the post  
**Docs:** `IOS/Kite/Kite/Kite/Doc/feature_comment.md`

---

## Goal

Finish the half-done comment rows so they look and behave like a real Kite comment:

1. **Smaller profile image** (current live cell is too big)
2. **Match the intended layout** (avatar | username · time · menu | caption | footer) using existing Style / Fonts / Colors / ImageStyle — same family as `PostCaption`
3. **Edit menu only for the comment author** (current logged-in user)
4. **Edit menu = Delete only** for this pass (no edit-caption yet)

```text
IndividualPostViewController
│
├── Row 0: Post cell
├── Row 1…N: CommentCell
│     ├── userImageArea          ← smaller circular avatar
│     └── right column
│           ├── header           ← username · time · [menu if mine]
│           ├── body             ← comment caption
│           └── footer           ← likes (existing / keep simple)
└── MakeComment (composer)       ← already works
```

---

## Product rules (lock this)

| Rule | Detail |
|------|--------|
| Who sees the ⋯ menu | Only when `comment.commentFrom` (or `userName`) == logged-in user |
| Menu actions (MVP) | **Delete** only |
| Non-author | No menu button (hidden / not in hierarchy) |
| Avatar size | Shrink from live **60×60 in 80-wide** column → target **~38–40 diameter** in a **~46–52-wide** column (match `PostCaption` / working commented layout) |
| Style source | `Fonts`, `Colors`, `ImageStyle.userProfileImage` — not debug salmon/lavender/gray backgrounds |

**Visual target:** Use `PostCaption` + the working commented `CommentCell` layout (username / time / menu / caption) as the design reference.  
If you have a mock screenshot, drop it in this Doc folder as `feature_comment_mock.png` and we will match that instead.

---

## Inspection result (what already exists)

### Live (half-done)

| Piece | Status |
|-------|--------|
| `IndividualPostViewController` | Loads `post.commentsArray`, registers `CommentCell`, calls `configureCommentCell` |
| `MakeComment` + `PostLogic.makeComment` | Create comment works |
| `.commentUpdated` observer | Reloads table |
| Live `CommentCell` | Scaffold only: **60pt** avatar, debug header/body/footer colors, configure sets **caption only** |

### Working reference (in code, not active)

| Piece | Where | Useful for |
|-------|--------|------------|
| Commented full `CommentCell` | Bottom of `CommentCell.swift` | Avatar ~48 / column ~68, `Style` fonts, username + time + menu |
| `CommentCellLayout` | `CodeBackupSort/DELETE/` (commented) | Same Instagram-style header row |
| `PostCaption` | `Post/Components/Post/PostCaption.swift` | **Best live style sibling:** 38pt avatar, 46-wide column, `Fonts` / `Colors` / `ImageStyle` |
| `UserCommentTemplate` | Backup templates | Older reusable comment view |

### Data on `Comment`

Already available for Step 2:

- `commentCaption`, `userName`, `commentFrom`, `firstName` / `lastName`
- `imageName`, `timeMessage`
- `commentLikeCount`, `commentLikedByCurrentUser`, `commentLikes`

Debug dump already prints these in `IndividualPostViewController.printDebugAllCommentsForPost()`.

### Delete API

| Wanted | Exists? |
|--------|---------|
| Soft-delete flag `comment_deleted` in DB | **Yes** |
| iOS `CommentsAPI` delete | **No** (only make / like / unlike) |
| Route `DELETE` / soft-delete comment | **No** in `commentRoutes.js` |

Step 3 needs a small API + client delete path (or confirm an existing hidden endpoint). Prefer soft-delete via `comment_deleted = 1`.

---

## Steps

### Step 1: Design and Layout (existing stylesheets) — ✅ Done

**Goal:** Comment row looks finished with placeholder / local images — no new design system.

**Done:**

- Live `CommentCell` rebuilt in-file (no layout extract)
- Avatar **38pt** in **46-wide** column via `ImageStyle.userProfileImage`
- Header: username · time · menu (`menu-dots-gray`)
- Body: expanding caption with `Fonts` / `Colors`
- Footer: compact like + count stub
- Debug salmon/lavender/gray backgrounds removed

**Primary file:** `App/Main/Post/Cells/CommentCell.swift`

---

### Step 2: Pulls in Real Data — ✅ Done

**Goal:** Every visible field comes from the real `Comment` on the post.

**Done:**

1. `configureCommentCell(with:)` sets username, time, caption, likes, and IDs
2. Avatar via `UsersDataController.getOrFetchUserWithImage` (same as `PostCaption`)
3. `IndividualPostViewController` already passes live `Comment` from `post.commentsArray`

**Primary files:**

- `CommentCell.swift`
- `IndividualPostViewController.swift` (wire configure only if needed)
- Image load helper already used by posts / `PostCaption`

---

### Step 3: Edit menu works (owner-only Delete) — ✅ Done

**Goal:** Author can delete their comment; everyone else never sees the menu.

**Done:**

1. Menu shown only when `commentFrom` / `userName` matches logged-in user
2. Menu = **Delete** only + confirm alert
3. API `POST /comment/delete` soft-sets `comment_deleted = 1` (author only)
4. `getPostComments` filters `comment_deleted = 0`
5. iOS: `CommentsAPI.deleteComment` → `PostLogic.deleteComment` → `PostDataController.removeComment` → `.commentUpdated`

**Primary files:**

- `CommentCell.swift` (menu visibility + action)
- `CommentsAPI.swift` + `PostLogic` / `PostDataController`
- `api/application/routes/commentRoutes.js` + `logic/comments.js` + `Comment.js` (soft delete)

---

## Suggested order of work

```text
Step 1  Layout + styles (smaller avatar, real chrome)
   ↓
Step 2  Bind Comment fields + imageName
   ↓
Step 3  Owner-only Delete (API + client + refresh)
```

One step at a time. Prefer finishing Step 1 visually before wiring delete.

---

## Out of scope (this feature)

- Edit / update comment text
- Nested / reply threads
- Comment like polish (footer can remain basic)
- Push notifications for new comments
- Rewriting `MakeComment`

---

## Open questions

1. **Mock image:** Please add `feature_comment_mock.png` to this Doc folder if the target layout differs from `PostCaption` + the working commented cell.
2. **Owner field:** Confirm production comments identify the author as `commentFrom` (preferred) vs `userName`.
3. **Delete API:** Soft-delete via `comment_deleted` — OK to add a new route in this feature?

---

## File map

| Role | Path |
|------|------|
| Screen | `App/Main/Post/IndividualPostViewController.swift` |
| Cell (finish this) | `App/Main/Post/Cells/CommentCell.swift` |
| Composer (leave) | `App/Main/Post/Components/Post/MakeComment.swift` |
| Style sibling | `App/Main/Post/Components/Post/PostCaption.swift` |
| Model | `Functions/Classes/Comment.swift` |
| API | `API/CommentsAPI.swift` |
| Backend routes | `api/application/routes/commentRoutes.js` |
