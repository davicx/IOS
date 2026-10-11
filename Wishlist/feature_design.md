# Kite Home feed — design plan

Status: plan only. Do not implement from this file until asked.

Direction: Option A. Instagram-inspired, minimal, content-first, with Kite pink kept for meaningful actions. This pass is the Wishlist Home feed and `ItemCell` only.

## Decision

Posts become full-width content on a white surface, separated by a hairline. The product image is the focus. Social actions sit under the image. The caption follows. A compact product title, price, and Purchase button stay visible so the feed still reads as a wishlist.

Do not redesign Profile, Discover, Lists, List Detail, the tab bar, list creation, APIs, or data models in this pass.

## Current architecture

Live files, Wishlist app (`IOS/Wishlist/Kite/Kite`):

```text
HomeViewController
└── postsTableView
    └── ItemCell
        ├── ItemHeader
        │   └── ItemInfo          product image, title, price, description, menu, Purchase
        ├── ItemBody
        │   └── ItemCaption       avatar, username, timestamp, caption
        └── ItemFooter
            └── ItemSocials       like icon + count, comment icon + count, bookmark icon
```

`ItemCell` is registered as `"ItemCell"` in four places:

| Screen | File |
| --- | --- |
| Home | `App/Main/HomeViewController.swift` |
| List detail | `App/Main/IndividualGroup/IndividualGroupViewController.swift` |
| Individual post | `App/Main/Post/IndividualPostViewController.swift` |
| Profile Items | `App/Main/Profile/UserProfile/AboutMe/Modules/ItemModule.swift` |

There is one cell class. A visual change to `ItemCell` will appear on all four screens. That is acceptable if the new layout is the shared post design. Do not fork a second cell. Do not add a pile of boolean layout flags.

Current Home presentation:

- Table background is `Colors.feedBackground` (`#F3F3F3`).
- Each post is a white card (`itemHolder`) with 16pt corners, a 1pt `Colors.separator` border, and a light shadow.
- Side inset is `Layout.spacingL * 0.8`. Vertical gap around the card is `Layout.spacingM`.
- Row height is `UITableView.automaticDimension`. Separator style is already `.none`.
- `ItemInfo` puts the product image beside the title, at 44% of the card width, `scaleAspectFit`. The Purchase button is full width under the description. A divider closes the header.
- `ItemCaption` is a 48pt avatar plus username, `post.timeMessage`, and `post.postCaption` as separate lines. It is not an inline “username caption” string.
- `ItemSocials` shows like, comment, and bookmark images. Like and comment counts are raw array counts. There is no Share control.

Images are loaded before the cell is configured. `PostDataController.loadPostsWithImages` fills `post.postImageData`. `ItemInfo.configure` assigns that image, or `nil` when it is missing. `ItemCaption` loads the avatar through `UsersDataController.getOrFetchUserWithImage` and ignores a stale username on reuse. `ItemCell` has no `prepareForReuse`.

## Tokens to adapt

Use the existing Style files. Do not add a second design system.

`Style/Colors.swift` already has `primaryPink` (`#FF2E7A`), `primaryBlue` (`#3797EF`), `subtleGrayText` (`#737373`), `screenBackground` (white), and `feedBackground` (`#F3F3F3`). Purchase buttons currently use `Colors.buttonPinkBackground`, which is `tikTokPink` (`#EF3D57`), not `primaryPink`.

For this pass:

| Token | Target | How |
| --- | --- | --- |
| `primaryPink` | `#FF2E6B` | Update the existing hex. Home Purchase uses this, not `tikTokPink`. |
| `primaryGrayText` | `#171717` | Update from black. This token is used widely, so the shift should stay near-black. |
| `subtleGrayText` | `#737373` | Already correct. Use it for timestamps and secondary labels. |
| `screenBackground` | `#FFFFFF` | Already white. Home table and cells use this. |
| `surfaceBackground` | `#F6F6F7` | Add. Use for the image backdrop when artwork does not fill the media area. Do not switch other screens onto it yet. |
| `dividerColor` | `#E8E8EA` | Add, or retarget the Home post divider only. Leave `Colors.separator` (`#ECECEC`) in place for screens this pass does not touch. |
| `primaryBlue` | `#3797EF` | Leave as the link color. Do not introduce it on the Home post. |

Leave `tikTokPink` and `buttonPinkBackground` alone so Lists, friends, and other buttons do not change color in this pass.

`Style/Fonts.swift` already has system fonts at the needed sizes: bold 28 (`newItemIntroTitleFont`), semibold 20, semibold 16 (`itemNameFont`), semibold 15 (`buttonTikTokFont`), semibold 14, regular 14 (`postCaptionFont`, `itemDescriptionFont`), regular 12 (`postedAtFont`). Add only the semantic names that are missing, such as a semibold 13–14 like-count font. Do not retarget Profile or List fonts.

`Style/Layout.swift` already has XS 4, S 8, M 12, L 16, XL 24, XXL 32, `iconSize` 24, and `touchTargetSize` 40. Add corner tokens: small 8, medium 12, large 16. Home posts use no outer radius. The Purchase button uses small (8). Do not add one-off padding numbers in the new layout when a spacing token fits. 10pt avatar gap and 4:3 media are component geometry, not new spacing tokens.

`Style/Buttons.swift` `wishlistPurchaseButtonStyle` stays the Purchase style, pointed at `primaryPink`, with an 8pt radius and semibold 15. Keep `buttonGrayStyle` for “You Purchased” and “Purchased”. Make the button hug its title instead of stretching full width.

## Target ItemCell order

```text
ItemCell                         white, no card, no shadow, no outer radius
├── header                       avatar, username, timestamp, existing menu
├── media                        full-width 4:3 region, scaleAspectFit
├── ItemSocials                  like, comment, bookmark
├── like count                   existing like array count
├── caption                      username + postCaption in one text block
├── ItemInfo                     title, price, description when present, Purchase
└── hairline                     dividerColor, 1px / screen scale
```

`ItemHeader`, `ItemBody`, and `ItemFooter` can stay as containers, but their current roles do not match this order. `ItemHeader` is product info today. `ItemBody` is the caption. `ItemFooter` is socials. Reorder the subviews inside `ItemCell` rather than inventing a parallel cell. Move the menu out of the product block and into the post header. Move the product image out of the side-by-side `ItemInfo` layout and into the media region.

### Header

`[40pt avatar]  username          [menu]`
`              timestamp`

Inset `Layout.spacingM` (12). Avatar-to-text gap 10. Username `Fonts.semibold14`, `primaryGrayText`. Timestamp `Fonts.postedAtFont`, `subtleGrayText`, from `post.timeMessage`. Menu keeps the existing `UIMenu` in `ItemInfo.setupMenu`: Edit and Delete. Edit currently only prints. Delete calls `PostLogic.shared.deletePost`. Do not add a report action. There is no avatar or username tap today, so do not add profile navigation in this pass.

### Media

Full cell width. Height is width × 3/4. No corner radius. `scaleAspectFit`. Backdrop `surfaceBackground`. Assign `post.postImageData` and clear the image when it is missing. Add `prepareForReuse` so a recycled cell cannot show the previous product or avatar. There is no stored media aspect-ratio field, so do not invent one. 4:3 is the first implementation.

### Social row

Keep like, comment, and bookmark. Do not add Share. Icons near-black, about 24pt, inside at least 44×44 touch targets. Bookmark stays trailing. Liked state keeps the existing `"Liked"` / `"like"` images. There is no bookmark saved-state in `configure`, and none of the three icons have targets. Do not wire new like, comment, or bookmark APIs in this visual pass. Show the same data they show now.

### Like count

One line under the icons: the existing `simpleLikesArray` count. Semibold 14, `primaryGrayText`, inset 12. Do not add plural copy or a second count. Comment count can stay beside the comment icon, as it does now.

### Caption

One multiline label: username in semibold 14, then `post.postCaption` in regular 14. Hide the block when the caption is empty. Do not also show the caption in the old stacked caption view. Do not use `itemDescription` as the caption.

### Product summary

```text
Secret of Mana                         [Purchase]
$49.99
description, only when itemDescription is non-empty
```

Title `itemNameFont`, two lines. Price `semibold15`. Description `itemDescriptionFont`, compact, only when the field has text. Purchase stays content-sized, pink, white semibold 15, 8pt radius, 44pt tall. Long titles must wrap beside the button, not under it.

Keep `PurchaseButtonState`: hidden, Purchase, You Purchased, Purchased. Those strings and `ItemCell.handlePurchaseAction` stay: Purchase presents `ItemPurchaseViewController`; You Purchased offers cancel through `PostLogic.removeItem`; Purchased shows who bought it.

### Divider

`dividerColor`, height `1 / UIScreen.main.scale`, after about `Layout.spacingM` of space. No shadow and no gray gap between posts.

## Home container

In `HomeViewController.setupTableView` only:

- `backgroundColor = Colors.screenBackground`
- `ItemCell` background matches
- Keep `automaticDimension`, `.none` separators, and the existing data source
- Remove the card insets, radius, border, and shadow from `ItemCell`
- Do not change `getHomePostsWishlist` or `PostDataController`

## Behavior to leave alone

These already work and must keep working:

- Purchase, You Purchased, and Purchased, including the purchase sheet and cancel-purchase alert
- Delete from the menu, including the failure alert
- Image assignment from `post.postImageData`
- Avatar fetch with the username reuse check
- Home row selection pushing `IndividualPostViewController` with `postID`
- Self-sizing rows

These do not exist on the cell today. Do not build them as part of the visual pass:

- Share
- Tapping like, comment, or bookmark
- Bookmark saved state
- A working Edit screen (the action prints `"edit"`)
- Report
- Avatar or username navigation
- Like-count pluralization
- A per-image aspect ratio

## Implementation order

1. Add or adjust the tokens listed above in `Colors.swift`, `Fonts.swift`, `Layout.swift`, and `wishlistPurchaseButtonStyle`. Do not restyle other screens.
2. Rebuild `ItemCell` constraints in the new order, reusing `ItemInfo`, `ItemCaption`, and `ItemSocials`.
3. Point Home’s table at `screenBackground` and delete the card chrome in `ItemCell`.
4. Build the Wishlist scheme and check Home, then spot-check List Detail, Individual Post, and Profile Items, because they share the cell.

## Verify

- Short title and caption
- Long title beside Purchase
- Long caption
- Empty description
- Missing image
- Portrait and landscape product art, including boxed game art
- Purchase, You Purchased, and Purchased
- Several posts with only a hairline between them
- Fast scroll with no stale image or avatar

Simulator check is required after implementation. This plan does not include that run.

## Out of scope

Profile, About Me, Lists, List Detail layout, Discover, tab bar, APIs, and models. Shared tokens may be added now. Other screens should not be restyled until Home is reviewed from the simulator.
