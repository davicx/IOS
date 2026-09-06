# Feature: Wishlist Item Post Components

**Status:** `ItemFrom` built (avatar / name / time / caption, 3-line max) — next: real `ItemImage` / `ItemInfo` leaves  
**Related:** Live Wishlist `PostCell` · [feature_new_item.md](./feature_new_item.md) · Design mock (Live A Live card) · `PostCaption.swift` (layout reference)  
**Folder:** `App/Main/Post/Components/Item/`

UIKit only. Programmatic Auto Layout. No Storyboards / XIBs.

Follow **existing project style patterns first**. Reuse `Colors`, `Fonts`, button helpers, spacing (`Layout`), corner radii, and Auto Layout patterns. Do not invent a separate design system inside these files.

---

## Goal

Break the Wishlist post into small reusable components that match the attached design.

```text
WishlistPost / PostCell
│
├── ItemHeader
│   ├── ItemFrom        ← dynamic height (content later; shell OK now)
│   └── ItemMenu        ← fixed ~44×44, top-aligned (rename from EditItem)
│
├── ItemBody
│   ├── ItemImage
│   └── ItemInfo
│       ├── ItemTitleArea
│       ├── ItemPriceArea
│       ├── ItemTagsArea
│       ├── ItemDescriptionArea ← dynamic up to max
│       └── ItemPurchaseArea
│
└── PostSocials         // ALREADY DONE — DO NOT CHANGE
```

**This phase — build:**

```text
ItemHeader.swift          ← owns ItemFrom + ItemMenu relationship
ItemBody.swift            ← owns ItemImage + ItemInfo relationship
ItemImage
ItemInfo + leaf areas (Title / Price / Tags / Description / Purchase)
ItemMenu                  ← rename EditItem; fixed menu shell
```

**Do not build / change yet:**

```text
ItemFrom content (UserInfo / Caption) — design layout for dynamic height later
PostSocials
API / models / fetch / purchase business logic
```

---

## Why `ItemHeader` and `ItemBody`

They each own a real layout job. They keep the cell from becoming the place every constraint lives.

| Layer | Owns |
|-------|------|
| **`WishlistPost` / `PostCell`** | Assembler only: vertical `ItemHeader` → `ItemBody` → `PostSocials` |
| **`ItemHeader`** | `ItemFrom` flexible + `ItemMenu` fixed / top-aligned |
| **`ItemBody`** | Image vs info width, spacing, alignment — not title/price internals |
| **`ItemInfo`** | Vertical stack of title → price → tags → description → purchase |

### Do not go further than this

Avoid over-componentizing:

```text
ItemHeaderContent
ItemBodyContent
ItemInfoContent
ItemTitleLabel
ItemPriceLabel
PurchaseButtonContainer
```

Stop at Header / Body / Info / leaf areas. That level stays helpful.

---

## `ItemHeader` — ItemFrom + ItemMenu

**Not** two equal columns. `ItemMenu` is a fixed menu-button container. **`ItemFrom` owns the header’s height.**

```text
┌──────────────────────────────────────────────┐
│ ItemFrom                          ItemMenu   │
│                                              │
│ davey · 10 months ago                •••     │
│ This caption can grow to another             │
│ line or two without moving the menu.         │
└──────────────────────────────────────────────┘
```

### Future content inside `ItemFrom` (do not implement UserInfo yet)

```text
ItemFrom
├── UserInfo          // IGNORE for now
│   ├── UserImage
│   ├── Username
│   └── Timestamp
└── Caption           // grows until max lines
```

### Constraints (critical)

```text
ItemFrom.leading  = header.leading
ItemFrom.top      = header.top
ItemFrom.bottom   = header.bottom

ItemMenu.trailing = header.trailing
ItemMenu.top      = header.top
ItemMenu.width    = fixed touch-target (~44)
ItemMenu.height   = fixed (~44)

ItemFrom.trailing = ItemMenu.leading  (with spacing)
```

**Do not** make `ItemFrom` and `ItemMenu` equal-height views.

**Do not:**

```swift
itemMenu.bottomAnchor.constraint(equalTo: header.bottomAnchor)
```

That stretches the menu with the caption. Instead pin menu top-trailing and fixed size:

```swift
itemMenu.topAnchor.constraint(equalTo: header.topAnchor)
itemMenu.trailingAnchor.constraint(equalTo: header.trailingAnchor)
itemMenu.widthAnchor.constraint(equalToConstant: 44)   // or Layout.touchTargetSize
itemMenu.heightAnchor.constraint(equalToConstant: 44)
```

Short vs long caption — `•••` stays put:

```text
SHORT
[davey  10 months ago]              [...]
Cool game!

LONG
[davey  10 months ago]              [...]
I've wanted this game for a
really long time and finally
added it to my list...
```

> **Do not make `ItemFrom` and `ItemMenu` equal-height views. `ItemFrom` determines the natural height of `ItemHeader`. `ItemMenu` is a fixed-size top-aligned menu-button area. The future caption inside `ItemFrom` may increase the header height up to its configured maximum number of lines.**

Rename shell `EditItem` → **`ItemMenu`**. It is not an editor — it is the `•••` control that may present Edit/Delete later.

---

## `ItemBody` — ItemImage + ItemInfo

```text
┌──────────────────────────────────────┐
│                  │ Title             │
│                  │ $49.99            │
│    ItemImage     │ tags              │
│                  │ description       │
│                  │                   │
│                  │ [ Purchase ]      │
└──────────────────────────────────────┘
```

- Image ≈ **40–45%** width; `ItemInfo` = remaining
- Prefer multipliers over device magic numbers
- Spacing clean/compact — Info children are **not** separate cards
- Do **not** stretch `ItemInfo` contents just because the image is taller

```swift
itemImage.widthAnchor.constraint(
    equalTo: itemBody.widthAnchor,
    multiplier: 0.4 // or ~0.40–0.45
)
```

---

## Dynamic height / maximum height behavior

**Content-driven up to a maximum** — not fixed-height blocks.

Do **not** give `ItemInfo`, `ItemDescriptionArea`, or future `ItemFrom` a fixed height.

### Sizing chain

```text
ItemFrom
   ↓ determines
ItemHeader height

ItemDescriptionArea
   ↓ contributes to
ItemInfo height
   ↓ contributes to
ItemBody height

ItemHeader
ItemBody
PostSocials
   ↓ determine
WishlistPost / cell height
```

Cap the two text areas that can explode:

```text
ItemFrom caption
    natural → MAX → truncate

ItemDescription
    natural → MAX (3 lines) → truncate
```

Everything above them responds naturally. **No giant fixed post height.**

### Cap pieces — not whole `ItemInfo`

```text
ItemFrom
  caption: flexible → MAX

ItemInfo
  title:       bounded
  price:       bounded
  tags:        bounded
  description: flexible → MAX
  purchase:    bounded
```

Do **not** put a hard `maxHeight` on all of `ItemInfo`.

### `ItemDescriptionArea`

```swift
numberOfLines = 0
lineBreakMode = .byTruncatingTail
```

- Short → natural height
- Long → max ≈ **3–4 lines**, then truncate
- Limit on the **label/component**, not by fixing `ItemInfo` height

### `ItemInfo`

Content / intrinsic driven. Do **not**:

```swift
itemInfo.heightAnchor.constraint(equalToConstant: ...)
```

Use hugging / compression resistance / stack spacing. Purchase stays toward the bottom when appropriate without hardcoding post height.

### Parent / cell

```text
Post height =
    ItemHeader (from ItemFrom)
  + ItemBody (from ItemInfo / image)
  + PostSocials
  + spacing
```

- Self-sizing cell (`UITableView.automaticDimension`)
- Avoid fixed post / cell heights
- Design parent so future `ItemFrom` caption can grow without rewriting the cell

**Shell note:** placeholder fixed `180` on image/info is temporary for visibility only. Drop fixed `ItemInfo` height in real components.

---

## Component specs (body leaves)

### `ItemImage`

- `UIImageView`, fills area, `.scaleAspectFit`
- Light gray / off-white background (existing colors)
- Rounded corners, clips, no unnecessary borders
- No text inside; parent owns size
- Simple configure (`UIImage?` / later from post)

### `ItemInfo`

Vertical stack:

```text
ItemTitleArea
ItemPriceArea
ItemTagsArea
ItemDescriptionArea
flexible spacing if needed
ItemPurchaseArea
```

Prefer `UIStackView` unless a stronger local pattern exists.

### `ItemTitleArea`

e.g. `Live A Live` — bold primary, 1–2 lines, slightly larger than body, left aligned. Use closest `Fonts` constant.

### `ItemPriceArea`

e.g. `$49.99` — semibold/bold, slightly smaller than title, tight under title. Separate label.

### `ItemTagsArea`

Pills e.g. `Physical` · `Nintendo Switch`.

- Horizontal; wrap if needed
- Primary tag: subtle green (reuse existing green)
- Secondary: soft gray bg, dark gray text
- Inspect `Colors` first — no near-duplicate tokens
- No generic tag framework yet

### `ItemDescriptionArea`

User item description (not the future header caption).

- Body font; primary/secondary per conventions
- Multiline; natural → max ~3–4 lines → truncate
- Distinct from title

### `ItemPurchaseArea`

- SF Symbol cart + “Purchase” (not emoji)
- Full width of `ItemInfo`
- Pink/red Wishlist accent (`Buttons.buttonPinkStyle` or existing purchase style)
- White icon/text, rounded, comfortable height
- Visual only unless an existing callback must be preserved

### `ItemMenu`

- Fixed ~44×44 (or `Layout.touchTargetSize`)
- Top-trailing in `ItemHeader`
- Placeholder / `•••` later; no Edit flow in this phase

---

## Component API

| Component | Configure with |
|-----------|----------------|
| `ItemImage` | image |
| `ItemTitleArea` | title |
| `ItemPriceArea` | price |
| `ItemTagsArea` | type / platform strings |
| `ItemDescriptionArea` | description |
| `ItemPurchaseArea` | title / state / optional action |
| `ItemInfo` | configures children |
| `ItemBody` | image + item fields → children |
| `ItemHeader` | from / menu (later) |

Prefer specific values over passing full `Post` into every leaf — unless siblings already use `configure(with: Post)`.

---

## File organization

Under `App/Main/Post/Components/Item/`:

```text
ItemHeader.swift
ItemBody.swift
ItemFrom.swift              // shell; content later
ItemMenu.swift              // rename from EditItem
ItemImage.swift
ItemInfo.swift
ItemTitleArea.swift
ItemPriceArea.swift
ItemTagsArea.swift
ItemDescriptionArea.swift
ItemPurchaseArea.swift
```

Do not move unrelated files. Do not refactor `PostSocials`. Leave `ItemInfoPullFrom` / `ItemContentPullFrom` as reference.

`PostCell` becomes a thin assembler of Header + Body + Socials.

---

## Style checklist (inspect before coding)

- [ ] `Colors` — primary / secondary text, pink accent, greens, item backgrounds
- [ ] `Fonts` — title / price / body / button
- [ ] `Buttons` — pink / purchase helpers
- [ ] `Layout.spacing*` / `touchTargetSize`
- [ ] Corner radii on Wishlist / New Item screens
- [ ] `setup*` / `configure*` naming nearby

Avoid inventing `customDarkGray2` / `wishlistGray3` / `newItemText` unless nothing fits.

---

## Out of scope (this phase)

- `ItemFrom` UserInfo + Caption content (layout must allow it later)
- `PostSocials` changes
- API / networking / models / fetch
- Purchase create/API behavior
- Equal-height header columns
- Fixed post / `ItemInfo` heights
- Extra wrapper layers listed under “Do not go further”

---

## Implementation order

| Step | Deliverable |
|------|-------------|
| **0 ✅** | Colored shells in `PostCell` |
| **1 ✅** | `ItemHeader` + `ItemBody` holders; `PostCell` owns Header / Body / Socials / Divider only (`EditItem` name kept) |
| **2** | Real `ItemImage` |
| **3** | Leaf areas: Title, Price, Tags, Description, Purchase |
| **4** | Compose leaves in `ItemInfo` → `ItemBody` |
| **5** | Polish wiring / self-sizing as needed |
| **6 ✅** | **`ItemFrom` content** — avatar / name / time / caption (3-line max) |
| **7** | Later: rename `EditItem` → `ItemMenu` + menu actions |

---

## Plan: Build `ItemFrom` (next)

**Scope:** Fill the orange `ItemFrom` shell only. Do not redesign `ItemBody` / `ItemInfo` leaves. Do not rename `EditItem`. Keep `ItemHeader` ownership as-is.

**Mirror:** `PostCaption.swift` structure (section comments, area views, configure, user image load).

**File:** `Components/Item/Components/ItemFrom.swift` (current location)

### Target layout (matches mock + caption under name)

```text
ItemFrom
┌────────────────────────────────────────────┐
│ userImageView   userNameView  postTimeView │
│                 postCaptionView            │
│                 (grows → max → truncate)   │
└────────────────────────────────────────────┘
```

Caption sits **below** username/time (mock header + your requirement). Menu stays in `EditItem` outside `ItemFrom`.

### Subviews — one view each

| View | Role |
|------|------|
| `userImageView` | Circular avatar |
| `userNameView` | Username (container + label, PostCaption-style) |
| `postTimeView` | Relative time e.g. “10 months ago” |
| `postCaptionView` | User post caption under name row; dynamic height → max |

Optional thin wrappers (same idea as PostCaption’s areas) if it keeps layout clear:

```text
userImageArea          ← holds userImageView
userMetaRow            ← userNameView + postTimeView horizontal
postCaptionView        ← holds caption label
```

Do **not** invent 10 tiny files for these — keep them **inside `ItemFrom.swift`** unless you later extract.

### File section style

```swift
//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS
```

Separate `setupUserImage…` / `setupUserMeta…` / `setupCaption…` like PostCaption.

### Style reuse (no new pinks)

| Need | Reuse |
|------|--------|
| Username | `Fonts.postUsernameFont` · `Colors.primaryGrayText` |
| Time | `Fonts.postedAtFont` · `Colors.postedAtTextColor` |
| Caption | `Fonts.postCaptionFont` · `Colors.postCaptionFontColor` |
| Avatar | `ImageStyle.userProfileImage(…)` (same ~38pt as PostCaption) |
| Gaps | `Layout.spacingXS` / `S` / `M` for name↔time, image↔text, padding |

Hardcode only component-specific sizes (avatar diameter, caption max lines) — Layout docs allow that.

**Colors:** do not add near-duplicate pink/gray. Temporary debug orange can stay until layout is verified, then go clear/white like the mock.

### Height rules (already in this doc)

```text
short caption → natural ItemFrom / ItemHeader height
long caption  → grow until MAX (3 lines) → truncate
```

```swift
// caption label
numberOfLines = 0
lineBreakMode = .byTruncatingTail
// + max 3 lines (label/layout limit — not fixed ItemFrom height)
```

`ItemFrom` stays content-driven (no `height = constant`). `ItemHeader` still: From owns height; `EditItem` top-trailing (tighten to fixed top-aligned later if still bottom-stretched).

### Configure / data

Follow PostCaption:

- `configure(with post: Post)` or specific fields: `postFrom`, `timeMessage`, `postCaption`, avatar via `UsersDataController.getOrFetchUserWithImage`
- Renderer only — no table refresh / NotificationCenter ownership

Empty caption → hide or collapse `postCaptionView` so header stays tight.

### Out of scope for this step

- `EditItem` / menu actions
- `ItemBody` / `ItemInfo` redesign
- `PostSocials`
- API / models
- Extracting caption into a shared component with PostCaption (OK to duplicate pattern for now)

### Done when

- [ ] Mock-like header: avatar · username · time
- [ ] Caption under name row; short/long height behavior works
- [ ] `EditItem` `•••` area unchanged beside it
- [ ] Uses existing Fonts / Colors / ImageStyle / Layout
- [ ] Looks like PostCaption code organization, not a new architecture

---

## End state (after body phase)

```text
[ ItemHeader: ItemFrom (later) | ItemMenu ••• ]

[ ItemBody: ItemImage | ItemInfo
                        title
                        price
                        tags
                        description (max lines)
                        Purchase ]

[ existing PostSocials ]
```

Self-sizing cell. Menu stays top-right when caption grows. Description caps independently. Assembler stays thin.

---

## Notes

- Prefer **`ItemMenu`** over `EditItem` — clearer intent.
- Height strategy: cap **description** and later **caption**; never a rigid full-post height.
- Purchase is visual first; Review / existing purchase flows stay the create path.
- Tags stay simple strings until real category/platform fields are wired.
