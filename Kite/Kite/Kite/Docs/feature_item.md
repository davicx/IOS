# Feature: Wishlist Item Post Components

**Status:** Step 1 structural holders done (`ItemHeader` + `ItemBody` in `PostCell`) — next is real `ItemImage` / `ItemInfo` leaves (not yet)  
**Related:** Live Wishlist `PostCell` · [feature_new_item.md](./feature_new_item.md) · Design mock (Live A Live card)  
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
    natural → MAX (~3–4 lines) → truncate
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
| **6** | Later: `ItemFrom` content + rename `EditItem` → `ItemMenu` + menu actions |

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
