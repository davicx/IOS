# Wishlist — Add Item from Photo

**Status:** Plan only. Do not implement from this file until a phase is chosen.  
**Codename:** `feature_item_from_photo`  
**Target:** Wishlist iOS (`IOS/Wishlist/Kite/Kite`) and `api`. Do not change `IOS/Kite`.

Choose a photo, optionally type a store, extract one product with OpenAI, then review and correct it. The user confirms with the existing Add Item flow. Extraction never creates a post or an item.

---

## 1. What exists today

### How a new item starts

`NewItemViewController` is the chooser. It pushes one of three screens and passes a fresh `ItemDraft` plus the list name. It does not create an item.

| Card | Screen |
|------|--------|
| Paste item details | `AddItemFromTextViewController` |
| Add a photo | `AddItemFromPhotoViewController` |
| Enter manually | `AddItemManuallyViewController` |

The privacy line on the chooser is already the right promise: nothing is posted until review.

`openPhoto()` is in `NewItemViewController`. The photo screen’s own comment says it must not call create.

### Photo screen

`IOS/Wishlist/Kite/Kite/App/Main/Item/ItemActions/AddItem/AddItemFromPhotoViewController.swift`

- White screen, nav title “Photo”, header “Add from a photo”.
- Subtitle today: “Upload a screenshot or product photo. You’ll fill in the details on the next screen.”
- Blue photo surface: `Colors.newItemPhotoCardBackground`, dashed `primaryBlue` border, corner radius 14, minimum height 220.
- Side inset is `Layout.spacingXXL` (32), not 20.
- Continue is `Buttons.buttonPinkStyle`, title “Continue to Review”, sparkles icon, height 52, corner radius 14.
- There is no Store field, no spinner, and no keyboard handling.
- Continue is always enabled. With no photo it only turns the border pink and stays on the screen.
- `UIImagePickerController`, library only, `allowsEditing = true`. The saved image is `editedImage` if the system crop editor returns one, otherwise `originalImage`.
- After a photo, the empty state hides and `photoPreviewImageView` shows the image with `scaleAspectFill`, so the preview is cropped to the box.
- The drop control stays tappable, but the “Change photo” title is hidden along with the empty state. There is no visible Change Photo control once an image is showing.
- `makeDraft()` returns the struct as-is. Continue pushes `ReviewItemViewController` with a copy.

### Crop

There is no crop view controller and no crop library in the Wishlist target. The only crop is the system square editor inside `UIImagePickerController` (`allowsEditing = true`) on the photo screen, manual entry, and review’s Edit Photo.

That editor is optional, square, and easy to skip. It is not a “crop to this product” tool. A screenshot of a cart can go straight to review.

### Draft

`IOS/Wishlist/Kite/Kite/App/Main/Code/ItemDraft.swift` is a struct.

| Field | Role today |
|-------|------------|
| `name` | Title |
| `price` | String until submit |
| `postText` | “Your post” |
| `productURL` | Link URL |
| `linkName` | Link display name |
| `localImage` | Photo used at create |
| `imageURL` | Unused by the photo path |
| `storeName` | Sample data only. Not shown, not sent |
| `groupID` | List to create into |

Because it is a struct, Review gets a copy. Edits on Review do not flow back to the photo screen. Popping Review shows the photo and store from before Continue, not the corrected fields.

### Review and create

`ReviewItemViewController` is the only create path for Paste, Photo, and Manual.

Fields: photo (96pt, Edit Photo), Title, Price, Link name, Link URL, “Your post (optional)”, list row, “Add to List”.

Required today: a photo and a non-empty title. Price, link, and post can be empty. The URL is not checked.

On submit, `PostLogic.createItemPost` calls `PostsAPI.makeItemPost`:

`POST http://localhost:3003/post/item`  
`multipart/form-data`, image field `postImage` as JPEG.

Body fields that matter here: `postCaption`, `itemName`, `itemPrice`, `itemDescription`, `itemLink`, `itemLinkName`, `groupID`, `postFrom`.

The review screen currently sends the “Your post” text as **both** `itemDescription` and `postCaption`. If that text is empty, both become the title. There is no separate product-description field on Review.

### API create and upload

`api/application/routes/itemRoutes.js`

- `POST /post/item` branches on `APP_LOCATION` and `FILE_LOCATION` to `items.postItemLocal` or `items.postItemLocalAWS`.
- It does **not** use `verifyUser`.

`uploadFunctions.uploadPostPhotoLocal` (`api/application/functions/uploadFunctions.js`):

- Multer `.single('postImage')`.
- JPEG or PNG only.
- 40 MB limit.
- Writes straight into the public posts folder (`./public/kite-us-west-two/` + `POSTS`).

Local create builds `http://localhost:3003/...` file URLs. AWS create then calls `awsStorage.uploadPost` and stores the S3 location. A missing file on create is allowed and a default image is substituted. Review does not allow a missing photo.

`Post.createPostItem` inserts `posts` and `items`, including `item_link_name` and `item_link`.

### Database

`items.item_link_name` already exists, `VARCHAR(255) NULL`, immediately before `item_link`. No new column is required for this feature.

`item_price` is `DECIMAL(10,2)`. There is no currency column. `validationFunctions.convertAndValidateDecimal` strips `$` and commas and stores a number. The card shows whatever string the app saved, so `$49.99` and `6.07` are both possible today.

`item_link` defaults to the literal `item_link`. The card hides that placeholder and hides the row when the URL is empty. A link name with no URL does not draw a tappable row. That already matches this feature.

### Auth

`middlewares.verifyUser` (`api/application/functions/middlewareFunctions.js`) accepts the `accessToken` cookie or `Authorization: Bearer`. Login sets an httpOnly `accessToken` cookie (`api/application/logic/login.js`). Wishlist `URLSession.shared` will send that cookie back to `localhost:3003`. Item create never checks it. Home `GET /items` does.

There is no rate-limit middleware anywhere in `api`.

### OpenAI

`api/package.json` depends on `openai` `^6.34.0`. The key is `OPENAI_API_KEY`, read only on the server.

`api/application/atlas/providers/openAI/client/openAIClient.js`:

- `getOpenAIClient()` builds one client. Timeout is `OPENAI_TIMEOUT_MS`, default 10 seconds.
- `createOpenAiChatCompletion` sends string message content only. It does not send images, and it does not set a JSON schema.
- Chat presets in `chatGPTconfig.js` are `gpt-4o-mini` and `gpt-4o`. Those are text chat settings, not an image-extraction setting.
- The helper logs request bodies. An extraction call must not go through that logger, because a cart screenshot can contain personal data.

Jest is configured with `roots: ["<rootDir>/test"]`. There are no item-route tests.

---

## 2. MVP

One image, one product, optional Store hint, editable review, confirm through `POST /post/item`.

If extraction fails or a field is missing, the person finishes the form by hand. The chosen photo stays.

Out of scope: carts as a batch, web search, invented product URLs, store image download, generated images, background removal, agents, and any new create endpoint.

---

## 3. Photo screen

Edit `AddItemFromPhotoViewController` only. Keep the white background, blue photo surface, dashed border, and pink Continue button.

Subtitle becomes:

> Upload a screenshot or product photo. We’ll find the details for you to review.

After a photo:

- Show the image with `scaleAspectFit` inside the existing blue area. Do not stretch it.
- Show a visible **Change Photo** action. Tapping the preview can keep opening the library.
- Continue stays disabled, and visually quiet, until `draft.localImage` is set.
- The image remains when the user comes back from Review.

Store block, between the photo area and Continue:

| | |
|--|--|
| Label | Store (optional) |
| Placeholder | Amazon, Target, Etsy… |
| Height | at least 52 |
| Background | `#F3F4F6`, the same gray as Edit Item fields |
| Corner | `Layout.cornerMedium` (12) |
| Horizontal text padding | 16 |
| Font | system 16 regular, the Edit Item field font |

Spacing for the new block: 24 pt (`Layout.spacingXL`) under the photo, 8 pt (`Layout.spacingS`) between label and field, 24 pt between the field and Continue. Keep the screen’s current 32 pt side inset so it does not jump away from the rest of this flow. The spec’s 20 pt margin is close; 32 is what this screen already uses.

`scrollView.keyboardDismissMode = .interactive`, plus the same keyboard inset the Edit Item screen uses, so a small phone can reach Continue.

Section comments when this file is edited: `//LOGIC`, `//UI COMPONENTS`, `//MANAGE VIEWS`, `//LAYOUT and UI`, `//ACTIONS`, `//FUNCTIONS`.

---

## 4. Crop

MVP uses the image the picker returns. If the person uses the system editor, that edited image is the extraction image and the proposed item photo. Review’s existing Edit Photo can replace it later.

Do not promise that the product will be cut out of a screenshot.

Several products in one image: stay on this screen and ask them to crop. The system editor only offers a square crop. That is a weak fit for a tall screenshot.

**Later, not MVP:** a real cropper (pinch and a free rectangle) if the system square editor is not enough. The extraction flow does not wait on that. `multiple_items` can still say “Crop the photo” and reopen the picker editor, with Choose Another Photo and Enter Manually beside it.

---

## 5. `POST /item/extract/`

Add it on `itemRoutes.js` under the item routes, next to create and edit.

```http
POST /item/extract/
Content-Type: multipart/form-data
```

| Field | Required | |
|-------|----------|--|
| `postImage` | yes | Same field name as create |
| `store` | no | The Store hint |

`verifyUser` runs first. Create does not, and this route should not copy that gap. The iOS call uses `URLSession.shared`, which already stores the login cookie. No token in the form body.

Do not use `uploadPostPhotoLocal`. That writes into the public posts directory. Extraction uses a multer memory (or os temp) storage used only by this route, JPEG/PNG, and a smaller limit than 40 MB. **8 MB** is enough for a phone JPEG and is the proposed cap. Reject anything else with the existing invalid-image style, without the “mah dude” copy.

The handler:

1. Requires a file. Store is optional, trimmed, max 80 characters.
2. Sends the image bytes and the store hint to the extraction service.
3. Validates the model JSON.
4. Returns the draft. No `posts` insert, no `items` insert, no S3 put, no public file path.

Memory storage does not leave a file to delete. If a temp file is used instead, delete it on success and failure.

---

## 6. OpenAI

New file: `api/application/logic/itemExtract.js`.

Use `getOpenAIClient()` from the existing client so the key and timeout stay in one place. Call `chat.completions.create` from this file with an image content part. Do not call `createOpenAiChatCompletion`. That helper cannot send an image, caps completion tokens at 512, and logs the prompt.

- Model from `ITEM_EXTRACT_MODEL`. Until that env var is set, default `gpt-4o`. Confirm the id against the current SDK docs when implementing. `gpt-4o-mini` is the chat default and is the wrong assumption for a screenshot.
- Timeout: the client default (10s) is short for a screenshot. Pass a 25s timeout on this call only, overridable with `ITEM_EXTRACT_TIMEOUT_MS`.
- One retry on HTTP 429 or a network drop. No retry on a refusal or invalid JSON.
- `temperature: 0`.
- Structured output: `response_format` JSON schema, strict. Verify the `openai` 6.x call shape at implementation time.
- The image is data, not instructions. The system text says to ignore any directions written inside the picture.

No fine-tune, no OCR product, no agent.

There is no shared rate limiter. For this route only, keep a small in-memory counter: 10 extractions per user per 10 minutes, keyed by `req.currentUser`. That is not a new platform. Log a request id, duration, and a short outcome (`ready_for_review`, `multiple_items`, `no_item_found`, `invalid_image`, `timeout`, `refused`, `bad_json`, `upstream`). Do not log the image, the description, the price, or the key.

---

## 7. What the model is asked to do

- One product only.
- Only what is visible.
- `null` when unknown. Do not invent a price, currency, URL, brand, or spec.
- Prefer the current item price. Ignore crossed-out prices, shipping, cart totals, installments, and other products.
- Use the selected variant when the screen shows one.
- Description is one or two short factual sentences from the image, not the marketing block.
- Do not write the user’s caption.
- If more than one product is clearly visible, status `multiple_items` and null item fields.
- If nothing is a product, status `no_item_found`.
- Store is a hint. If the image names a different store, keep the user’s store in `store`, put the conflict in `warnings`, and do not silently replace it.
- A URL is returned only when the characters are readable in the image. No homepage stand-in. No ASIN guessed from a title.

A physical product photo may return only a name. Price and link stay null.

---

## 8. Response

Match the usual API envelope (`data`, `success`, `message`, `statusCode`, `errors`, `currentUser`).

```json
{
  "success": true,
  "message": "",
  "statusCode": 200,
  "errors": [],
  "currentUser": "davey",
  "data": {
    "status": "ready_for_review",
    "item": {
      "name": "The Field Guide (The Spiderwick Chronicles)",
      "price": "6.07",
      "currency": null,
      "description": "Paperback edition by Tony DiTerlizzi.",
      "store": "Amazon",
      "linkName": "Amazon",
      "linkURL": null
    },
    "warnings": []
  }
}
```

`status` is `ready_for_review`, `multiple_items`, or `no_item_found`.

`price` is a string with up to two decimal places, or null. The server checks it with a digit-and-dot pattern. It does not run the value through `parseFloat`.

`currency` is an ISO code when the symbol or word is visible (`USD` for a visible `$` only when the screen is clearly dollars). Otherwise null. It is not stored.

`linkURL` is null, or an `http` / `https` URL. Anything else becomes null and a warning.

Server-side validation drops extra keys. A response that is not the schema becomes a failure, not a half-filled item.

---

## 9. Field mapping

| Extraction | Draft | Review control | `POST /post/item` |
|------------|-------|----------------|-------------------|
| `item.name` | `name` | Title | `itemName` |
| `item.price` | `price` | Price | `itemPrice` |
| `item.description` | `productDescription` (new) | Description (new) | `itemDescription` |
| `item.linkURL` | `productURL` | Link URL | `itemLink` |
| `item.linkName` | `linkName` | Link name | `itemLinkName` |
| `item.store` | `storeHint` (new) | Does not replace a link name the user already typed | not sent |
| image | `localImage` | Photo | `postImage` |
| caption | `postText` | Your post | `postCaption` |

`storeName` on the draft stays unused. Use `storeHint` so it is not confused with that sample field.

Currency is not a column. If `currency` is `USD` or the image showed `$`, the price string on the form may be `$6.07`, which create already accepts. If currency is null, the form gets `6.07` with no symbol added.

`productDescription` is new on `ItemDraft` only. No migration.

Review submit changes in one place:

- `itemDescription` is `productDescription` when that field is non-empty.
- Otherwise keep today’s behavior: the post text, or the title if the post is empty.
- `postCaption` is the post text, or the title if the post is empty. It is no longer a copy of the AI description.

Manual entry leaves `productDescription` empty, so manual create stays as it is.

Link name without a URL is allowed. `ItemInfo` already hides the row unless `itemLink` is a real URL.

---

## 10. Review

Same `ReviewItemViewController`. Add a Description field under Price, same 16 pt field style as the other inputs, multiline, minimum about 96 pt. Placeholder “Add a description”. Helper under the photo, only when this draft came from extraction:

> We filled in what we could. Check the details before adding.

Empty extraction values stay empty. “Your post” is not filled by the model.

Before Add to List, if Link URL is non-empty, it must parse as `http` or `https`. Otherwise show a short alert and do not post. Empty URL is fine.

Add to List still calls `PostLogic.createItemPost` → `POST /post/item`.

---

## 11. Multiple products and unreadable photos

`multiple_items`: stay on the photo screen. Keep the image and Store text. Message:

> More than one item was found. Crop the photo to the item you want to add.

Actions: Crop Photo (reopens the picker editor), Choose Another Photo, Enter Manually. Manual pushes Review with the photo and any Store hint already placed in Link name, other fields empty.

`no_item_found`:

> We couldn’t find an item in this photo.

Choose Another Photo, and Enter Manually with the photo kept.

A single tentative name is `ready_for_review` with the other fields null. Review shows the name and blank price, link, and description.

---

## 12. Loading and failure

Continue dismisses the keyboard, disables itself, and shows a spinner with **Finding item details…**. A second tap does nothing while the request is out.

The photo screen keeps an incrementing request id. When the response arrives, ignore it if the id does not match, or if the image has changed. Leaving the screen cancels the `Task`.

Failures that all use the same message:

> We couldn’t read the details from this photo. Try again or enter them yourself.

That covers offline, bad image, too large, timeout, rate limit, refusal, bad JSON, and HTTP 5xx. The raw OpenAI error stays on the server.

**Try Again** repeats extract. **Enter Manually** opens Review with the photo and whatever the user typed, and does not clear the image.

---

## 13. Don’t extract twice for the same picture

On `ItemDraft`, keep:

- `extractionToken`: a value that changes when the image or the Store hint changes.
- `extractionResult`: the last successful payload, or nil.
- `fieldsFromExtraction`: which fields were filled by the model, so we know what the user has since edited.

Same image and same Store hint: Continue reuses `extractionResult` and does not call the API.

A new photo, a new crop, or a changed Store hint clears `extractionResult`.

If the user already edited a prefilled field and the token is now stale, Continue asks before replacing those edits. It does not overwrite them silently.

Nothing is written to the database for this cache.

Going back from Review writes the edited draft onto `AddItemFromPhotoViewController` in `viewWillDisappear` when Review is popping. The struct copy is why this handoff has to be explicit.

---

## 14. Images

iOS sends JPEG from `jpegData`, same as `makeItemPost`, so HEIC from the library is converted before the request. Downscale the longest side to about 1600 px before upload so screenshot text stays readable and the body stays under 8 MB.

Server checks the multer type and the magic bytes (`FF D8` for JPEG, PNG signature). A renamed file is rejected.

Orientation: `UIImage.jpegData` bakes in the orientation the picker shows. The server does not need a second rotate step for the MVP.

No sharp dependency exists. Do not add one for this.

---

## 15. Files

**Create**

- `api/application/logic/itemExtract.js` — prompt, schema, OpenAI call, normalize.
- `api/test/application/items/itemExtract.test.js` — mocked client.

**Edit**

- `api/application/routes/itemRoutes.js` — `POST /item/extract/`.
- `api/application/functions/uploadFunctions.js` — memory upload for this route only, or a sibling export. Do not point it at the posts folder.
- `IOS/Wishlist/.../AddItem/AddItemFromPhotoViewController.swift`
- `IOS/Wishlist/.../AddItem/ReviewItemViewController.swift`
- `IOS/Wishlist/.../Code/ItemDraft.swift`
- `IOS/Wishlist/.../API/PostsAPI.swift` — `extractItem` next to `makeItemPost`.

No change to `Post.createPostItem`, the items table, or `IOS/Kite`.

---

## 16. Phases

1. **Endpoint.** Route, auth, memory upload, `itemExtract.js`, mocked tests. No database writes.
2. **iOS request.** Photo screen Store field, disabled Continue, spinner, `PostsAPI.extractItem`, draft token.
3. **Review.** Description field, prefill, helper, URL check, caption split, back navigation, manual fallback, multiple-item and failure copy.
4. **Crop polish.** Only if the system square editor is not enough. Then rerun the verification list.

---

## 17. Verification

Automated, with a fake OpenAI client:

- A product screenshot maps to that product’s name and the current price, not a struck-through price.
- A cart screenshot does not return the subtotal as the item price.
- Missing URL and missing price stay null.
- `store` arrives in the prompt and comes back on `item.store`.
- Two products return `multiple_items` and no item insert.
- Garbage JSON and a refusal return a failure envelope.
- The test asserts no `Post.createPostItem` and no `Item.updateItemDetails` call.

Manual, with real screenshots, wording allowed to vary:

- Continue with no photo does nothing.
- The same photo and store does not call extract again.
- Changing the store or the photo does.
- Review edits are still there after going back.
- Try Again does not create two items.
- A failed extract still shows the photo.
- Add to List hits `POST /post/item` and the JPEG is the picture they picked.
- Enter manually, with no extract, still creates an item as it does now.
- A link name and no URL does not show a tappable row on the card.

---

## 18. Decisions already made

- Extraction is `POST /item/extract/` and uses `verifyUser`. Create stays the existing route.
- The OpenAI call is new and image-specific. It reuses the client, not the text-chat helper.
- `item_link_name` is the link label. No schema change.
- Currency is not stored. A visible `$` may be kept on the price string. An unknown currency is not labeled.
- The system square crop is enough to start. A free cropper is phase 4.
- There is no app-wide rate limiter. This route gets a small in-memory cap.
