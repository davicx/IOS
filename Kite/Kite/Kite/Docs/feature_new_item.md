# Feature: New Item (Wishlist)

**Status:** Step 1 done — next is Step 2 (`ItemDraft` + nav conventions)  
**Related:** [feature_wishlist_new_item.md](./feature_wishlist_new_item.md) (product / AI / extraction) · List screen + `+ Add Item` entry  
**Reference:** Design mock (Choose → Paste / Photo → Review)

UIKit only. Programmatic Auto Layout. No Storyboards / XIBs. Match the “New Item” chooser; later screens follow the same visual language.

---

## Architecture rule

> **Nothing posts an item except Review Item.**

Paste may later use AI. Photo may later use vision. Manual needs no AI. Regardless of how the draft was filled, everything lands on the same editable Review screen before anything is saved.

```text
Chooser
    ├── Paste
    ├── Photo
    └── Manual
          │
          ▼
     ItemDraft
          │
          ▼
     Review Item
          │
          ▼
     Add to List  ← only place that calls create API
```

Do **not** build a segmented Paste / Photo / Manual header. The chooser already answers “how do you want to add this?” Switching modes mid-flow adds state and nav complexity with little benefit.

Do **not** add an `AddItemFlowViewController`. One fullscreen `UINavigationController` *is* the flow coordinator for something this small.

---

## Goal

```text
Chooser → Paste / Photo / Manual → Review → Add to List
```

All three paths share one `ItemDraft` → one Review screen. Do **not** build AI, networking, or image recognition until Step 8.

---

## Existing code (as of Step 1)

| File | Role |
|------|------|
| `App/Main/Post/ItemActions/NewItemViewController.swift` | Chooser UI |
| `App/Main/Post/ItemActions/NewItemOptionView.swift` | Option cards |
| `App/Main/Post/ItemActions/AddItemFromTextViewController.swift` | Paste placeholder |
| `App/Main/Post/ItemActions/AddItemFromPhotoViewController.swift` | Photo placeholder |
| `App/Main/Post/ItemActions/AddItemManuallyViewController.swift` | Old manual form (still submits directly — temporary until Step 4) |
| `App/Main/IndividualGroup/IndividualGroupViewController.swift` | Presents `UINavigationController(root: NewItemViewController)` fullscreen |
| `App/Main/Post/PostActions/NewPostViewController.swift` | Kite event create — leave alone |
| `Docs/feature_wishlist_new_item.md` | Broader AI / extraction plan |

### Design system

| Token / helper | Use |
|----------------|-----|
| `Colors.primaryPink` / `buttonPinkBackground` | Accent, close, paste card |
| `Colors.primaryBlue` | Photo card icon |
| `Colors.primaryText` / `secondaryText` | Titles / body |
| `Colors.screenBackground` | White |
| `Colors.newItem*` | Card tints / borders / info strip |
| `Fonts.newItem*` | Intro + option + info fonts |
| `Layout.spacing*` | Gaps / icons |
| `Buttons.buttonPinkStyle` | Primary CTAs on Review / input screens |

### Navigation conventions (locked in)

- Present **one** `UINavigationController` fullscreen from the list (`IndividualGroupViewController` already does this).
- Every child uses **`pushViewController`**.
- Chooser **X** dismisses the **entire** nav controller.
- Back chevron returns to the previous screen in the stack.
- Do **not** create a second tab bar; Lists stays selected underneath the modal.

---

## Folder layout

```text
App/Main/Post/ItemActions/
├── NewItemViewController.swift              ← chooser ✅
├── NewItemOptionView.swift                  ← cards ✅
├── AddItemFromTextViewController.swift      ← Paste
├── AddItemFromPhotoViewController.swift     ← Photo
├── AddItemManuallyViewController.swift      ← Manual (stops submitting after Step 4)
├── ItemDraft.swift                          ← Step 2
└── ReviewItemViewController.swift           ← Step 3
```

`PostActions/` stays Kite/post actions. Wishlist **create** stays in `ItemActions/`.

---

# STEP 1 ✅ — Chooser + shells

**Done.** Chooser matches mock. Paste / Photo placeholders. Manual = existing form (may still call create API until Step 4).

---

# STEP 2 — Shared `ItemDraft` + navigation conventions

**Scope:** One draft model every path speaks. Confirm nav rules above. Little/no new UI.

### Why early

Paste, Photo, Manual, and Review should share one language **before** more screens are built. Avoid three different “almost drafts” that get reconciled later.

### Model

```swift
struct ItemDraft {
    var name: String
    var price: String?          // stay String while editing; convert at submit
    var postText: String?       // what the user wants to say (not product copy)
    var productURL: String?
    var imageURL: String?       // remote, if any
    var localImage: UIImage?    // local pick / screenshot — fine for MVP
    var storeName: String?
    var groupID: Int
}
```

**Naming notes**

- Prefer **`postText`** (or `note`) over `description` — product info and “what I want to say” are different concepts.
- Keep **`price` as `String`** in the draft. Parse / format for the API only in Review’s submit path.
- `imageURL` + `localImage` are fine for MVP. An image-state enum later is premature.
- Align naming with `WishlistItemDraft` in the wishlist doc if needed — **one** model only.

### Nav checklist

- [ ] Still one fullscreen `UINavigationController` for the whole add-item flow
- [ ] Children only `push` / `pop`
- [ ] Chooser X dismisses the nav
- [ ] No `AddItemFlowViewController`
- [ ] No Paste | Photo | Manual segment control

### Done when

- [ ] `ItemDraft` exists and compiles
- [ ] Placeholders (and Manual) can accept / produce a draft even if fields are empty
- [ ] Docs / code comments state: only Review will create

---

# STEP 3 — Review Item screen

**Scope:** Editable Review UI only. CTA can print or no-op; wire create in Step 7.

Fields (match mock):

- Title, Price, post text / note, photo
- “Add to list” row (list name + chevron) — display current list for now
- Primary pink CTA: **Add to List**

Review owns the draft it was given (edit in place or copy — keep it simple).

### Done when

- [ ] Can push Review with a sample `ItemDraft` and edit fields
- [ ] Looks consistent with List / chooser (white, pink accent, `Layout`)
- [ ] Still no create API call (or guarded behind a temporary path only if needed)

---

# STEP 4 — Manual → Draft → Review

**Scope:** Manual stops being a forever-submit form.

- Manual collects fields into `ItemDraft`
- Continues → Review (push)
- **Remove** direct `createItemPost` from Manual once Review exists
- Temporary: Manual may still submit until this step lands — then only Review saves

### Done when

- [ ] Manual → Review with populated draft
- [ ] Manual no longer calls create API

---

# STEP 5 — Paste UI → Draft → Review

**Scope:** Real Paste UI (text area + CTA). No AI.

- Non-empty paste required to continue
- Easy heuristic OK: detect URL → `productURL`; else put blob into `postText`
- Push Review with draft
- **No** backend scrape

---

# STEP 6 — Photo picker → Draft → Review

**Scope:** Library / camera pick + preview. No OCR.

- Set `localImage` on draft; other fields empty for user fill on Review
- Push Review
- Reuse existing picker patterns where possible

---

# STEP 7 — Review → create API → refresh → dismiss

**Scope:** The only create path.

- Review **Add to List** → `PostLogic.createItemPost` (or equivalent)
- Convert draft fields (incl. price string) at submit time
- On success: dismiss entire nav, refresh list (`fetchGroupWishlistItems`)
- Loading + simple error handling
- Clear temp image / draft

### Done when

- [ ] Paste / Photo / Manual all save only through Review
- [ ] List updates after dismiss

---

# STEP 8 — Extraction / OCR / link intelligence (optional)

Deferred to [feature_wishlist_new_item.md](./feature_wishlist_new_item.md):

- Link metadata / scrape
- Screenshot OCR / vision
- Always editable on Review; app works fully without AI

---

## Visual checklist (chooser = Step 1)

| Element | Spec |
|---------|------|
| Background | White |
| Close | `xmark`, pink accent |
| Title | “New Item”, semibold, black |
| Intro title | “How do you want / to add this item?” ~27–30 bold, centered |
| Intro subtitle | “We’ll pull out the item details for you.” ~15–16 gray |
| Cards | 3 stacked, ~120–125 tall, r≈16, 1pt border, ~16pt gap, inset ~28–32 |
| Paste / Photo / Manual | Pink / blue / gray tints + SF Symbols as mocked |
| Info strip | Lock icon + privacy copy, not tappable |
| Tab bar | Do not rebuild |

---

## Explicitly out of scope

- Segmented Paste | Photo | Manual header
- `AddItemFlowViewController` / extra flow coordinator layer
- Storyboards / SwiftUI
- Duplicate tab bar
- Bright blue/green legacy CTAs on this flow
- AI / OCR / scrape before Step 8
- Changing Home, Friends, Discover, Profile, or Kite `NewPostViewController`
- Keeping Manual as a permanent direct-submit path after Step 4

---

## Implementation order

| Step | Deliverable |
|------|-------------|
| **1 ✅** | Chooser + cards + placeholders + existing manual form |
| **2** | Shared `ItemDraft` + navigation conventions |
| **3** | Review Item screen |
| **4** | Manual → Draft → Review |
| **5** | Paste UI → Draft → Review |
| **6** | Photo picker → Draft → Review |
| **7** | Review → create API → refresh list → dismiss |
| **8** | Extraction / OCR / link intelligence |
