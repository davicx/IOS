# Kite — Wishlist Quick Add

## Goal

Make adding an item to a wishlist extremely easy.

A user should be able to add an item in three ways:

1. Paste a product link
2. Upload/select a screenshot
3. Enter the item manually

All three flows should eventually produce the same normalized wishlist item model and show the same editable preview before saving.

The app must continue to work completely without AI or automatic extraction.

---

# Product Flow

Entry point:

```text
Add Wish
```

Present three options:

```text
Paste Link
Add Screenshot
Enter Manually
```

Do not build three completely separate item creation systems.

All three should populate the same draft object:

```swift
WishlistItemDraft
```

Then open the same:

```text
WishlistItemEditor
```

The user can correct anything before saving.

---

# 1. Shared Draft Model

Create a temporary model representing an item before it is saved.

Suggested shape:

```swift
struct WishlistItemDraft {
    var name: String
    var price: String?
    var description: String?
    var productURL: String?
    var imageURL: String?
    var localImage: UIImage?
    var storeName: String?
}
```

Use the naming/style conventions already present in the Kite codebase if equivalent models already exist.

Do not duplicate this structure if there is already an appropriate wishlist/post draft model.

The important rule is:

```text
Link Import
Screenshot Import
Manual Entry
        ↓
WishlistItemDraft
        ↓
WishlistItemEditor
        ↓
Save
```

---

# 2. Add Wish Menu

Find the existing wishlist add button / creation flow.

When the user taps Add Wish, show a small action sheet or modal with:

```text
Add to Wishlist

Paste Link
Add Screenshot
Enter Manually
Cancel
```

Prefer existing Kite modal/action-sheet patterns rather than introducing a new UI system.

Suggested responsibilities:

```swift
WishlistAddViewController
```

or equivalent existing screen/component.

It should only decide which creation method the user wants.

Do not put extraction logic inside the view controller.

---

# 3. Manual Entry

This is the baseline flow and must always work.

Create/reuse an editor containing:

```text
Image

Item Name *
Price
Store
Product Link
Description

Add to Wishlist
```

Suggested component:

```swift
WishlistItemEditorViewController
```

Input:

```swift
WishlistItemDraft
```

For manual creation:

```swift
WishlistItemDraft(
    name: "",
    price: nil,
    description: nil,
    productURL: nil,
    imageURL: nil,
    localImage: nil,
    storeName: nil
)
```

The user fills it out and saves normally.

Only `name` should be required unless the current database schema already requires additional fields.

---

# 4. Paste Link

## UI

When the user selects:

```text
Paste Link
```

show a simple input:

```text
Paste a product link

[ https://example.com/product ]

Continue
```

If there is already a URL in the system clipboard, it is fine to pre-fill it.

Do not automatically read/use the clipboard without the normal iOS behavior/permission UX.

---

# 5. Link Import Architecture

Do not put website parsing directly in the iOS app.

The iOS app should send the URL to the Kite/Navigator backend.

Suggested request:

```http
POST /wishlist/import/link
```

Body:

```json
{
  "url": "https://example.com/product"
}
```

Suggested response:

```json
{
  "name": "Nike Air Max 90",
  "price": "$130",
  "description": "Men's shoes",
  "product_url": "https://example.com/product",
  "image_url": "https://example.com/image.jpg",
  "store_name": "Nike"
}
```

All fields except `product_url` may be null.

The frontend should convert this directly into:

```swift
WishlistItemDraft
```

and open the editor.

The user must always be able to modify the imported values.

---

# 6. Backend Product Extraction

Create a focused service such as:

```text
wishlist/
    import/
        importWishlistItemFromURL.js
        extractProductMetadata.js
```

Follow the existing Navigator project structure if there is already a better folder convention.

Do not build a universal crawler framework.

For V1, fetch the page HTML and inspect common structured metadata.

Extraction priority:

```text
1. JSON-LD Product data
2. Open Graph metadata
3. Standard HTML metadata
4. Basic page title fallback
```

Look for values such as:

```html
<meta property="og:title">
<meta property="og:image">
<meta property="og:description">
<meta property="product:price:amount">
<meta property="product:price:currency">
```

Also inspect:

```html
<script type="application/ld+json">
```

for:

```json
{
  "@type": "Product",
  "name": "...",
  "image": "...",
  "description": "...",
  "offers": {
    "price": "...",
    "priceCurrency": "USD"
  }
}
```

Normalize whatever is found into one result:

```js
{
  name,
  price,
  description,
  productURL,
  imageURL,
  storeName
}
```

Do not make the frontend understand individual websites.

---

# 7. Extraction Failure

Extraction failure is NOT an error that prevents the user from continuing.

Example:

User pastes a URL.

Backend only determines:

```json
{
  "name": null,
  "price": null,
  "description": null,
  "product_url": "https://...",
  "image_url": null,
  "store_name": null
}
```

The app should still open the editor with the URL populated.

The user can manually fill in the rest.

This behavior is important.

The feature enhances manual entry; it does not replace it.

---

# 8. Screenshot Import

When the user selects:

```text
Add Screenshot
```

use the existing iOS photo picker.

Prefer:

```swift
PHPickerViewController
```

or whatever modern photo picker Kite already uses.

Allow one image.

After selection:

```text
Screenshot
    ↓
Upload to backend
    ↓
AI extraction
    ↓
WishlistItemDraft
    ↓
Editor
```

The selected image should remain available to display as the wishlist image even if AI extraction fails.

---

# 9. Screenshot Backend Endpoint

Suggested endpoint:

```http
POST /wishlist/import/image
```

Send the image using the same upload conventions already used by Kite.

Do not invent a second image upload system if Kite already uploads profile images, group images, post images, etc.

Reuse that infrastructure.

Backend responsibility:

```text
receive image
↓
send image to OpenAI vision
↓
request structured product information
↓
normalize result
↓
return draft
```

Suggested response:

```json
{
  "name": "Nike Air Max 90",
  "price": "$130",
  "description": "White and blue Nike sneaker",
  "product_url": null,
  "image_url": null,
  "store_name": "Nike"
}
```

The original uploaded screenshot should still be associated with the draft as its local/uploaded image.

---

# 10. OpenAI Screenshot Extraction

Put all OpenAI logic behind one dedicated service.

For example:

```text
wishlist/import/extractWishlistItemFromImage.js
```

Do not call OpenAI directly from the iOS app.

The OpenAI request should ask only for extraction.

Do NOT ask it to generate marketing copy or guess information.

Conceptually:

```text
Analyze this screenshot of a potential product.

Extract only information visible or strongly identifiable from the image.

Return:

name
price
brand/store
short description

If a value cannot be determined, return null.

Do not invent missing prices, product names, URLs, or specifications.
```

Require structured JSON output.

Expected shape:

```json
{
  "name": null,
  "price": null,
  "store_name": null,
  "description": null
}
```

Validate the response before returning it to the app.

AI output is suggestion data only.

The user must review it before saving.

---

# 11. Loading State

Both automatic imports need a simple loading state.

For example:

```text
Getting item details…
```

Do not create a complicated progress system.

On success:

```text
open WishlistItemEditor
```

On partial success:

```text
open WishlistItemEditor
```

On failure:

```text
Couldn’t automatically get the item details.
You can still add it manually.
```

Then open the editor with whatever information is available.

---

# 12. Image Behavior

Wishlist items should support either:

```text
remote product image URL
```

or:

```text
uploaded/local image
```

Prefer an actual extracted product image when importing from a URL.

Prefer the screenshot itself when importing from an image.

The UI should not care where the image originated.

Create/reuse one image presentation component.

Conceptually:

```swift
WishlistItemImageView
```

It should handle:

```text
local image
remote image
placeholder
```

using the existing Kite image-loading infrastructure.

---

# 13. Saving

Do not create separate database save paths like:

```text
saveManualWish()
saveLinkWish()
saveScreenshotWish()
```

All three should eventually call the same existing/new save function.

Example:

```swift
saveWishlistItem(draft)
```

Backend:

```http
POST /wishlist/items
```

or reuse the existing wishlist creation endpoint.

The saved item does not need to know whether it originally came from AI unless that information is genuinely useful later.

Keep the persisted model simple.

Potential fields:

```text
id
wishlist_id
user_id
name
description
price
store_name
product_url
image_url / image reference
created_at
updated_at
```

Adapt to the existing schema instead of creating duplicate fields.

---

# 14. Important Architecture Rule

The importer creates a DRAFT.

It does not directly create a wishlist item.

BAD:

```text
paste URL
→ backend parses
→ immediately saves item
```

GOOD:

```text
paste URL
→ backend parses
→ draft
→ user reviews
→ save
```

Same for screenshots.

This gives us protection against bad metadata and AI mistakes.

---

# 15. V1 Scope

Build this in this order.

### Step A — Shared editor

Make sure one editor can accept:

```swift
WishlistItemDraft
```

and save it.

Manual entry should work first.

### Step B — Paste Link UI

Add:

```text
Add Wish
→ Paste Link
→ URL field
→ import
→ editor
```

### Step C — Backend URL extraction

Implement common metadata extraction.

Do not add OpenAI to URL parsing yet unless absolutely necessary.

### Step D — Screenshot selection

Add:

```text
Add Wish
→ Screenshot
→ Photo Picker
→ editor
```

At minimum, the screenshot should already be usable as the item image.

### Step E — OpenAI screenshot extraction

Add AI-generated:

```text
name
price
store
description
```

to pre-fill the same editor.

---

# 16. Explicitly Do Not Build Yet

Do NOT build:

```text
browser extension
universal ecommerce crawler
Amazon-specific integration
Target-specific integration
Nike-specific integration
background web crawling
price monitoring
automatic price updates
product search engine
affiliate links
OCR framework
AI-generated descriptions
automatic saving without review
Share Extension
```

Those can come later.

The architecture should not prevent a future iOS Share Extension, but do not implement it in this feature.

Eventually it should be possible for a Share Extension to simply call the same URL import flow:

```text
Safari
→ Share
→ Kite
→ URL importer
→ WishlistItemDraft
→ Add
```

---

# 17. Error Handling

Handle these cleanly:

```text
invalid URL
website blocks request
metadata does not exist
metadata contains relative image URL
JSON-LD is malformed
multiple JSON-LD objects exist
product has no price
OpenAI returns missing values
OpenAI request fails
image upload fails
user cancels photo picker
remote product image cannot load
```

None of these should crash the creation flow.

Whenever reasonable, fall back to manual editing.

---

# 18. Security / Backend Safety

For URL importing, do not blindly allow the backend to request arbitrary internal/private network addresses.

Validate URLs.

Only support:

```text
http
https
```

Reject obviously unsafe/local/internal destinations.

Add reasonable request timeout and response-size limits.

We are importing normal public product pages, not building a generic URL fetch API.

---

# 19. Logging

Development logging should make the flow easy to understand.

Something simple like:

```text
WISHLIST IMPORT

Source: Link
URL: https://...
Metadata:
✓ Name
✓ Image
✓ Price
- Description

Result: Draft Created
```

For screenshots:

```text
WISHLIST IMPORT

Source: Screenshot
Image Upload: Success
OpenAI Extraction:
✓ Name
✓ Price
✓ Store
- Product URL

Result: Draft Created
```

Do not log image binary data or giant HTML documents.

---

# 20. Code Organization

Keep this feature small.

A reasonable conceptual structure is:

```text
iOS
Wishlist/
    Add/
        WishlistAddViewController
        WishlistLinkImportViewController
        WishlistItemEditorViewController
        WishlistItemDraft
        WishlistImportService

Backend
cloudPilot? NO
wishlist/
    import/
        importWishlistItemFromURL
        extractProductMetadata
        extractWishlistItemFromImage
```

Use the actual existing Kite/Navigator folder conventions rather than blindly creating these exact folders.

This functionality belongs to Wishlist/Kite.

Do not put it into CloudPilot architecture just because OpenAI is involved.

---

# Definition of Done

The feature is complete when all of these work:

```text
1. Add Wish → Manual
   → user enters name
   → item saves

2. Add Wish → Paste Link
   → backend attempts extraction
   → item editor opens pre-filled
   → user edits
   → item saves

3. Paste Link where extraction fails
   → editor still opens
   → URL remains populated
   → user manually completes item

4. Add Wish → Screenshot
   → user selects screenshot
   → screenshot appears in editor
   → AI attempts to fill fields
   → user edits
   → item saves

5. OpenAI unavailable
   → screenshot can still be added manually

6. Incorrect AI result
   → user can change every generated field before saving
```

## Core principle

Keep this feature boring underneath.

There should be one wishlist item editor and one wishlist save path.

Link parsing and screenshot AI are simply two convenient ways of pre-filling that editor.

Do not turn wishlist importing into a large framework.
