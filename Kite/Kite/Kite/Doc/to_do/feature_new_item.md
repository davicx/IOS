# Feature: New Item (Wishlist)

**Status:** Step 7 done — next is Step 8 (optional extraction / OCR)  
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

## Existing code (as of Step 4)

| File | Role |
|------|------|
| `App/Main/Post/AddItem/NewItemViewController.swift` | Chooser UI |
| `App/Main/Post/AddItem/NewItemOptionView.swift` | Option cards |
| `App/Main/Post/AddItem/AddItemFromTextViewController.swift` | Paste UI → Draft → Review ✅ |
| `App/Main/Post/AddItem/AddItemFromPhotoViewController.swift` | Photo picker → Draft → Review ✅ |
| `App/Main/Post/AddItem/AddItemManuallyViewController.swift` | Manual → Draft → Review ✅ |
| `App/Main/Post/AddItem/ItemDraft.swift` | Shared draft model ✅ |
| `App/Main/Post/AddItem/ReviewItemViewController.swift` | Review UI + create ✅ |
| `App/Main/IndividualGroup/IndividualGroupViewController.swift` | Presents `UINavigationController(root: NewItemViewController)` fullscreen |
| `App/Main/Post/PostActions/NewPostViewController.swift` | Kite event create — leave alone |
| `Docs/feature_wishlist_new_item.md` | Broader AI / extraction plan |

### Design system

| Token / helper | Use |
|----------------|-----|
| `Colors.primaryPink` / `buttonPinkBackground` | Accent, close, paste card |
| `Colors.primaryBlue` | Photo card icon |
| `Colors.primaryGrayText` / `subtleGrayText` | Titles / body |
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
App/Main/Post/AddItem/
├── NewItemViewController.swift              ← chooser ✅
├── NewItemOptionView.swift                  ← cards ✅
├── AddItemFromTextViewController.swift      ← Paste → Review ✅
├── AddItemFromPhotoViewController.swift     ← Photo → Review ✅
├── AddItemManuallyViewController.swift      ← Manual → Review ✅
├── ItemDraft.swift                          ← Step 2 ✅
└── ReviewItemViewController.swift           ← Step 3 ✅
```

`PostActions/` stays Kite/post actions. Wishlist **create** stays in `AddItem/`.

---

# STEP 1 ✅ — Chooser + shells

**Done.** Chooser matches mock. Paste / Photo placeholders. Manual = existing form (may still call create API until Step 4).

---

# STEP 2 ✅ — Shared `ItemDraft` + navigation conventions

**Done.** `ItemDraft` shared by Paste / Photo / Manual. Chooser pushes empty draft. Placeholders + Manual expose `makeDraft()`. Only Review will create (Manual still temporary-submits until Step 4).

Nav locked: one fullscreen `UINavigationController`, push/pop only, chooser X dismisses, no segment control, no flow coordinator VC.

---

# STEP 3 ✅ — Review Item screen

**Done.** `ReviewItemViewController` edits Title / Price / Link / post / photo, shows Add to list row, pink **Add to List** CTA (print only — create in Step 7). Temp: Paste placeholder **Continue to Review** pushes sample draft.

---

# STEP 4 ✅ — Manual → Draft → Review

**Done.** Manual builds `ItemDraft` via `makeDraft()`, pushes Review. Direct `createItemPost` removed. CTA: **Continue to Review**.

---

# STEP 5 ✅ — Paste UI → Draft → Review

**Done.** Real Paste UI (text area, examples, pink CTA). Non-empty required. URL → `productURL`; otherwise blob → `postText`. Pushes Review. No scrape / AI.

---

# STEP 6 ✅ — Photo picker → Draft → Review

**Done.** Photo UI (dashed drop zone + preview). Library picker (same pattern as Review/Manual, no shared helper). Sets `localImage` on draft; other fields empty for Review. Photo required to continue. No OCR.

---

# STEP 7 ✅ — Review → create API → refresh → dismiss

**Done.** **Add to List** → `PostLogic.createItemPost`. Requires photo + title. Spinner + error alert. On success: refresh wishlist (`fetchGroupWishlistItems`), clear draft, dismiss entire nav. Only create path for Paste / Photo / Manual.

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
| **2 ✅** | Shared `ItemDraft` + navigation conventions |
| **3 ✅** | Review Item screen |
| **4 ✅** | Manual → Draft → Review |
| **5 ✅** | Paste UI → Draft → Review |
| **6 ✅** | Photo picker → Draft → Review |
| **7 ✅** | Review → create API → refresh list → dismiss |
| **8** | Extraction / OCR / link intelligence |
