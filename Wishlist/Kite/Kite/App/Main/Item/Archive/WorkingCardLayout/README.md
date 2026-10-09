# Working Item Card Layout (archived 2026-10-07)

Snapshot of the card that looked good before the full-width Item Info reorder.

These are `.txt` copies so Xcode will not compile them. Open them next to the live `.swift` files to compare or copy pieces back.

## Structure

```text
ItemCell
  itemHolder
    ItemHeader
      ItemFrom
      menuButton
    ItemBody
      ItemInfo          ← gray product panel (inset)
      ItemCaption
    ItemFooter
      ItemSocials
```

## Live files to restore into

| Archive | Live path |
|---|---|
| `ItemCell.swift.txt` | `Item/Cells/ItemCell.swift` |
| `ItemHeader.swift.txt` | `Item/ItemHeader.swift` |
| `ItemBody.swift.txt` | `Item/ItemBody.swift` |
| `ItemFooter.swift.txt` | `Item/ItemFooter.swift` |
| `ItemInfo.swift.txt` | `Item/Components/ItemInfo.swift` |
| `ItemFrom.swift.txt` | `Item/Components/ItemFrom.swift` |
| `ItemCaption.swift.txt` | `Item/Components/ItemCaption.swift` |
| `ItemSocials.swift.txt` | `Item/Components/ItemSocials.swift` |

To restore one file: copy the `.txt` contents over the live `.swift` file (keep the `.swift` name).
