# Feature: Lists Index Redesign

**Status:** Steps 1–6 implemented — visual polish / mockup compare remaining  
**Scope:** `IOS/Kite/Kite/Kite` only  
**Screen:** `GroupsViewController` presented as **Lists**  
**Visual source:** Supplied Lists mockup and the measurements locked below  
**Priority:** Match the mockup closely before adding unrelated behavior

### Implementation progress

- [x] Step 1 — Page shell and navigation (`My Lists`, pink add, real avatar, tab → Lists)
- [x] Step 2 — Intro subtitle + restyled `ListsHeaderView` list type selector
- [x] Step 3 — `GroupCell` preview card with real data (no ID/type)
- [x] Step 4 — Member avatars via controller-coordinated `UsersDataController` fetch
- [x] Step 5 — Create-new-list card on My Lists only
- [x] Step 6 — Loading / empty / error states
- [ ] Step 7 — Final visual pass against `Doc/feature_lists_mock.png`

---

## Goal

Redesign the current sparse Groups index into a polished **Lists** page while preserving its working data, filtering, creation, and navigation behavior.

This is a UIKit layout and styling task. It is not a model rewrite, networking rewrite, or broad app refactor.

Visible copy must use **List / Lists**. Internal types, endpoints, and storage may continue to use `Group`.

---

## Product rules

- Keep UIKit and programmatic Auto Layout.
- Keep the existing `UITableView`; do not convert it to a collection view only for appearance.
- Keep `GroupModel`, `GroupDataController`, and `GroupsAPI`.
- Keep the existing `CreateGroupViewController` presentation.
- Keep list selection navigating to `IndividualGroupViewController`.
- Keep the existing tab bar implementation.
- Rename the visible tab from **Groups** to **Lists**.
- Use pink for Lists selection and important creation actions.
- Do not use blue as the active Lists-page accent.
- Do not display group IDs, raw group types, database keys, or debug text.
- Do not use `ThickBlackDivider`.
- Do not add hardcoded sample lists.
- Do not put page-specific styles into `AllStyle.swift`.
- Do not add a new design system.

---

## Current implementation inspection

### Active page

`App/Main/GroupsViewController.swift`

The page already:

- Fetches groups through `GroupDataController.shared.getGroups`.
- Filters the response to `groupType == "wishlist"`.
- Separates owned and shared lists by comparing `createdBy` with the logged-in username.
- Switches between **My Lists** and **Shared With Me**.
- Presents `CreateGroupViewController` from the add action.
- Pushes `IndividualGroupViewController` when a row is selected.
- Passes `groupID` and `currentUserOwnsGroup` to the destination.
- Reloads after group updates.

The page currently has:

- A standard `UINavigationController` navigation bar, not a custom page-header component.
- Placeholder title `"Nav Bar"`.
- A 28-point hardcoded local avatar (`background_14`) rather than the current user's loaded profile image.
- A standard add bar item.
- A table pinned to the full view.
- A 60-point `ListsHeaderView`.
- No presentable loading, empty, or error UI.

### Current list cell

`App/Main/Groups/cells/GroupCell.swift`

The active cell currently shows centered labels for:

- Group name
- Creator
- Group ID
- Raw group type

It has no card surface, image, metadata treatment, member avatars, privacy badge, right arrow, or reuse-aware asynchronous image loading.

`GroupCell` should be redesigned in place and remain the reusable cell. Renaming it to `ListPreviewCell` is optional and not required for this visual pass.

`App/Main/Groups/cells/ListCell.swift` and the nearby `ListHeader`, `ListImage`, `ListMembers`, and `ListSocials` files are compiled scaffolds with debug placeholder surfaces. They are not wired to the live index. Do not switch to them merely because their names say “List,” and do not carry their `ThickBlackDivider` into the redesign.

### Existing segmented header

`App/Main/Groups/Lists/Components/ListMasterHeader.swift`

It already owns:

- `My Lists`
- `Shared With Me`
- Selection callback
- Animated underline position

It currently uses:

- A stripped default `UISegmentedControl`
- 80% width
- 30-point control height
- A thick-looking black underline

Keep the selection callback and index behavior, but rebuild its appearance to match the mockup.

### Destination

`App/Main/IndividualGroup/IndividualGroupViewController.swift`

The destination already accepts:

- `groupID`
- `currentUserOwnsGroup`

It loads the selected Wishlist's items and members and uses the current Wishlist visual language through:

- `IndividualListHeader`
- `IndividualListMembers`
- Pink add-item action
- White content and soft-gray feed surfaces

Do not change this navigation contract during the Lists index redesign.

### Create-list flow

`CreateGroupViewController` is currently compiled into the app even though its source is physically located under:

`App/Main/CodeBackupSort/Docs/MaybeOld/Sort/CreateGroupViewController.swift`

`GroupsViewController.openCreateGroup()` presents it as a page sheet. Both the header add button and the create-new-list card must call that same action.

Do not move or redesign the create flow as part of this feature. Its internal hardcoded Kite-specific values are a separate concern.

### Bottom tab bar

`Functions/Helpers/AppTabBarFactory.swift`

The app uses a standard `UITabBarController`. The current item is:

- Title: `Groups`
- Symbol: `person.3`
- Tag: `1`

For this feature:

- Change the visible title to `Lists`.
- Prefer `list.bullet.rectangle` or the closest supported list symbol.
- Set the selected tab tint to `Colors.primaryPink` at the tab-bar level if it is not already configured elsewhere.
- Keep all tab order, tags, view controllers, and navigation wrapping unchanged.

---

## Existing data available for each card

The index API returns `GroupModel` values through:

- `API/GroupsAPI.swift`
- `API/Models/Groups/GroupModel.swift`
- `Functions/Controllers/GroupDataController.swift`

### Available now

- **List name:** `groupName`
- **Description:** `groupDescription`
- **Cover image URL:** `groupImage`
- **Creator:** `createdBy`
- **List type:** `groupType` — use only for internal filtering
- **Active member usernames:** `activeGroupMembers`
- **Pending member usernames:** `pendingGroupMembers`
- **Ownership:** derive by comparing `createdBy` to `GroupDataController.shared.currentUser`
- **Member count:** derive from unique active members
- **Member profile images:** fetch active usernames through `UsersDataController.fetchUsersWithImages`

### Not available from the current index response

- Item count
- Privacy (`group_private` is stored by the backend but is not returned by the current groups index endpoint or represented by `GroupModel`)
- A dedicated shared/private display state
- Preloaded member profile image objects

### Required hiding behavior

- Hide item count because it is not returned. Do not fetch every list's items and do not expand the backend in this task.
- Do not show `Private` or `Shared` as a factual privacy value because privacy is absent.
- For an owned list with no other active members, the badge may say **Only me** because that is derivable from the member usernames.
- For a list with other active members, the badge may say **Shared** because membership is real, but it must not imply the backend privacy flag.
- Hide the avatar row until member profiles have loaded successfully.
- Never show pending members as active overlapping avatars.
- Hide the description when it is empty.

### Legacy placeholder warning

The model and backend currently fall back to:

`this is my new group so cool`

That is implementation placeholder text, not trustworthy user content. The redesigned cell must not present it as a real description. During implementation, normalize empty or known legacy placeholder descriptions to hidden. Do not invent replacement copy.

`GroupsResponseModel.init()` also contains a sample fallback group. `GroupDataController` currently assigns response data after decoding, which can leak placeholder content after a decode failure.

The backend's current `getGroups` response does not reliably update its top-level `success` and `statusCode` values before returning real data, so implementation must **not** simply reject every response where `success == false`; that would hide valid lists. Use a minimal, explicit fetch/decode result instead:

- Preserve valid decoded `data`.
- Change the local fallback response data from a sample group to an empty array.
- Surface transport/decode failure to the controller's error state without fabricating a row.
- Do not change the group endpoint contract as part of the visual redesign.

### Existing create-flow warning

The currently compiled `CreateGroupViewController` contains pre-existing hardcoded creation values, including a username and `groupType = "kite"`. Because this index filters to `groupType == "wishlist"`, a newly created record may not appear in this Lists screen.

Its multipart request also accepts a selected `groupImage`, but currently does not append the image bytes to the request body. The create screen has no description input.

The redesign must preserve both add entry points and verify the create flow in testing. If the username/type mismatch is confirmed, fix only the inputs needed to pass the logged-in user and Wishlist type. Do not redesign the create screen or add description/image-upload scope to this feature.

`GroupsViewController` also clears `onGroupsUpdated` in `viewWillDisappear` and does not reinstall it in `viewWillAppear`. Confirm callback ownership during implementation so returning from a modal or pushed screen cannot silently stop future list updates; keep any correction local to this controller.

---

## Existing style sources

Use these active non-`Sort` files:

- `Style/Colors.swift`
- `Style/Fonts.swift`
- `Style/Layout.swift`
- `Style/Style.swift`
- `Style/Buttons.swift`
- `Style/ImageStyle.swift`
- `Style/Dividers.swift`

### Reuse these tokens

Colors:

- `Colors.screenBackground`
- `Colors.primaryPink`
- `Colors.primaryGrayText`
- `Colors.secondaryGrayText`
- `Colors.subtleGrayText`
- `Colors.separator`
- `Colors.newItemCardBorder`
- `Colors.newItemInfoBackground`
- `Colors.buttonGrayBackground`
- `Colors.newItemPasteCardBackground`
- `Colors.newItemPasteIconBackground`

Fonts:

- `Fonts.listNameFont`
- `Fonts.listDescriptionFont`
- `Fonts.regular12`
- `Fonts.regular13`
- `Fonts.regular14`
- `Fonts.regular15`
- `Fonts.semibold14`
- `Fonts.semibold18`
- `Fonts.semibold20`

Layout:

- `Layout.spacingXS` = 4
- `Layout.spacingS` = 8
- `Layout.spacingM` = 12
- `Layout.spacingL` = 16
- `Layout.spacingXL` = 24
- `Layout.spacingXXL` = 32
- `Layout.iconSize` = 24
- `Layout.touchTargetSize` = 40

Images and buttons:

- `ImageStyle.userProfileImage(imageView:diameter:)`
- `Buttons.buttonPinkStyle(button:)` where its 6-point radius fits
- Use a page-specific 12–14 point corner radius for the square header add button instead of forcing the generic 6-point button style.

### Current visual references

`App/Main/Post/AddItem/NewItemViewController.swift`

- White background
- Centered supporting copy
- Pink navigation action
- 12/16/24/32-point spacing
- Soft-gray information surface

`App/Main/Post/AddItem/NewItemOptionView.swift`

- 122-point compact card
- 16-point card radius
- 1-point `newItemCardBorder`
- Circular icon treatment
- `Layout.spacingL` internal padding
- Native alpha highlight
- Compact right arrow

`App/Main/IndividualGroup/IndividualList/Components/IndividualListHeader.swift`

- `Fonts.listNameFont`
- `Fonts.listDescriptionFont`
- Compact image-and-details layout
- Pink Wishlist actions
- 8–12 point internal spacing

These are the primary style references. Do not copy old placeholder List components or `Sort` styling.

---

## Locked screen structure

```text
Safe Area / Existing Navigation Bar
├── Left: current-user avatar
├── Center: My Lists
└── Right: pink add button

Table Content
├── Intro subtitle
├── My Lists | Shared With Me segmented control
├── List preview card
├── List preview card
├── List preview card
└── Create New List card (My Lists only)

Existing Bottom Tab Bar
```

Use the existing navigation bar as the compact page header. Do not add a second header below it.

The subtitle and segmented control should live together in a reusable table header so they scroll naturally with the list while the navigation bar remains fixed.

---

## Visual specification

### 1. Navigation header

Use the existing `navigationItem`.

Left:

- Custom `UIButton` inside `UIBarButtonItem`
- 40 × 40-point touch target
- Visible avatar approximately 40 points
- `ImageStyle.userProfileImage(..., diameter: 40)`
- Load with `UsersDataController.shared.getOrFetchUserWithImage(username: currentUser)`
- Clean local fallback while loading
- Accessibility label: `Open profile`
- Keep the existing `openProfile` selector; do not invent new navigation behavior

Center:

- Text: `My Lists`
- `Fonts.semibold20`
- `Colors.primaryGrayText`
- Single line
- Standard compact navigation proportions
- No large-title mode

Right:

- Custom 40 × 40-point button
- `Colors.primaryPink` background
- White `plus` symbol at approximately 17–18 points
- Corner radius: 13 points
- Accessibility label: `Create a new list`
- Calls existing `openCreateGroup`

Horizontal alignment should visually respect `Layout.spacingL`. Do not add heavy shadows or a gradient.

### 2. Intro and segmented header

Target total height: approximately 112–120 points.

Subtitle:

- Text: `Keep wishes organized and share them with friends.`
- `Fonts.regular15`
- `Colors.secondaryGrayText`
- Center aligned
- One line when width permits
- Top inset: `Layout.spacingM`
- Horizontal inset: `Layout.spacingL`

Segment container:

- Top gap from subtitle: `Layout.spacingL`
- Leading/trailing inset: `Layout.spacingL`
- Height: 50 points
- Bottom inset: `Layout.spacingM`
- Background: `Colors.newItemInfoBackground`
- Corner radius: 13 points
- Clips to bounds

Segments:

- Equal width
- Full-height native buttons or controls with at least 40-point touch targets
- Active selection background: white
- Active text: `Fonts.semibold14`, `Colors.primaryGrayText`
- Inactive text: `Fonts.regular14`, `Colors.secondaryGrayText`
- Active underline: `Colors.primaryPink`
- Underline height: 2 points
- Underline width: selected half minus 16-point side breathing room
- Underline bottom inset: 3 points
- Selection movement: existing short 0.2–0.3 second animation

Do not use default blue selection, a thick black underline, or a fully pink segment.

### 3. Table

- Background: `Colors.screenBackground`
- Separator style: none
- Content inset: top 0, bottom `Layout.spacingXL`
- Vertical scroll indicator may remain native
- Estimated row height: 144 points, not the current 480
- Use automatic row height only if two-line title/description requires it
- Deselect a row immediately after tap

Card spacing:

- Outer horizontal inset: `Layout.spacingL`
- Gap between visible cards: `Layout.spacingM`
- Implement with 6-point transparent cell padding above and below, or an equivalent 12-point row-to-row gap

### 4. List preview card

Target:

- Standard card height: 128 points
- Allow growth to approximately 144 points only when a two-line title or description requires it
- White background
- Border: 1 point using `Colors.newItemCardBorder`
- Corner radius: 16 points
- No shadow by default
- Internal inset: `Layout.spacingM`
- Entire card selectable

Recommended active hierarchy:

```text
UITableViewCell
└── cardView
    ├── coverContainer
    │   ├── coverImageView
    │   └── fallbackIconView
    ├── detailsStack
    │   ├── nameLabel
    │   ├── descriptionLabel (optional)
    │   ├── metadataStack (optional)
    │   └── footerRow
    │       ├── avatars / ownership text (optional)
    │       └── membershipBadge
    └── rightArrowImageView
```

### 5. Cover image

- Size: 92 × 92 points
- Leading inset: `Layout.spacingM`
- Vertically centered
- `.scaleAspectFill`
- Clips to bounds
- Corner radius: 12 points

Loading:

- Keep an image-loading `Task` owned by the cell.
- Cancel it in `prepareForReuse`.
- Store/configure the expected `groupID` and verify it before applying an asynchronous result.
- Use the existing image URL and image-loading utilities; do not add a library.
- A shared existing cache may be used if it accepts arbitrary image URLs.

Fallback:

- Soft pink background: `Colors.newItemPasteCardBackground`
- Centered `gift.fill` or `list.bullet.rectangle` SF Symbol
- Symbol tint: `Colors.primaryPink`
- Symbol size: approximately 26 points
- Do not show `background_1`, random stock imagery, or generated content as the missing-list-image fallback

### 6. Main text

Details leading gap from cover: `Layout.spacingM`.

List name:

- `Fonts.listNameFont`
- `Colors.primaryGrayText`
- One line normally; maximum two
- `.byTruncatingTail`

Description:

- `Fonts.listDescriptionFont`
- `Colors.subtleGrayText`
- Maximum two lines
- `.byTruncatingTail`
- Hide when empty or equal to the known legacy placeholder
- Remove its arranged spacing when hidden

Vertical gaps:

- Name to description: `Layout.spacingXS`
- Description/name to metadata: `Layout.spacingS`
- Metadata to footer: `Layout.spacingS`

### 7. Metadata

Only render real available values.

Member count:

- `person.2`
- Text such as `3 members`
- Count unique active member usernames
- `Fonts.regular13`
- `Colors.subtleGrayText`
- Icon: approximately 15–16 points
- Icon-to-text gap: `Layout.spacingXS`

Creator:

- For owned lists: `Created by you`
- For shared lists: `Created by <username>`
- `Fonts.regular13`
- `Colors.subtleGrayText`
- Hide if creator is absent

Item count:

- Hidden in this feature because the index response does not contain it
- The cell may include a hidden optional label for future use, but `configure` must not fabricate a value

If horizontal room is limited, member count takes priority over creator text.

### 8. Member avatars and badge

For lists with real loaded active-member profiles:

- Show up to three avatars
- 28 × 28 points
- Circular
- 1.5-point white border
- Overlap by 8 points
- Exclude duplicate usernames
- If more than three active members exist, optionally add a `+N` circle
- Do not show pending users in the avatar cluster

If no profile images are successfully available:

- Hide the avatar cluster cleanly
- Do not show empty circles

Badge:

- Background: `Colors.newItemInfoBackground` or `Colors.buttonGrayBackground`
- Text: `Fonts.regular12`
- Text/icon: `Colors.secondaryGrayText`
- Height: approximately 24 points
- Horizontal padding: 8 points
- Corner radius: 8 points

Derivable labels:

- `Only me` with `person.fill` when the owner is the only active member
- `Shared` with `person.2.fill` when other active members exist

These labels communicate membership, not backend privacy. Do not use a lock icon or claim `Private` because the API does not return the privacy field.

### 9. Right arrow

- Right-arrow SF Symbol (Apple's system image name is `chevron.right`)
- Approximately 14 × 16 points
- `Colors.secondaryGrayText`
- Trailing inset: `Layout.spacingM`
- Vertically centered
- Not separately interactive

### 10. Tap feedback

Use native, restrained feedback:

- Cell selection style or card alpha around 0.72–0.85 while highlighted
- Restore immediately on release/cancel
- No scaling animation unless it exactly matches an existing app convention

The whole card must remain the tap target.

---

## Create-new-list card

Show this after existing rows on **My Lists** only.

Do not show it on **Shared With Me**.

Target:

- Height: 96 points
- Same `Layout.spacingL` outer inset as list cards
- Same 16-point corner radius
- White or `Colors.newItemPasteCardBackground`
- 1-point pink border using `Colors.primaryPink.withAlphaComponent(0.25)`
- No shadow

Left icon:

- 44-point soft-pink circle
- `plus` symbol
- `Colors.primaryPink`

Text:

- Title: `Create a new list`
- `Fonts.semibold14` or `Fonts.semibold15`
- `Colors.primaryPink`
- Subtitle: `Make a list for any occasion and invite friends.`
- `Fonts.regular13`
- `Colors.subtleGrayText`
- Maximum two lines

Action:

- Calls the exact same `openCreateGroup` path as the header add button
- Accessibility label: `Create a new list`

This card is a secondary path and must remain visually quieter than real list cards.

---

## State behavior

The screen must have one explicit display state at a time:

```text
loading
content
emptyMyLists
emptySharedLists
error
```

This may be implemented locally in `GroupsViewController`; do not create a new app-wide state architecture.

### Loading

- Show a centered `UIActivityIndicatorView` in the list content area.
- Keep header and segment visible.
- Hide rows, creation card, empty state, and error state.
- Stop loading on both success and failure.

### Empty — My Lists

- Symbol: `gift`
- Title: `No lists yet`
- Message: `Create a list to keep gift ideas, favorites, and things you want in one place.`
- Pink action: `Create a List`
- Action calls `openCreateGroup`

Typography:

- Title: `Fonts.semibold18`
- Body: `Fonts.regular14`
- Body color: `Colors.subtleGrayText`

Keep the block compact and vertically centered in the available table area, not directly attached to the segmented control.

When this empty state is visible, do not also show the create-new-list card.

### Empty — Shared With Me

- Symbol: `person.2`
- Title: `Nothing shared yet`
- Message: `Lists shared with you by friends will appear here.`
- No create button

### Error

- Short title: `Couldn’t load lists`
- Message: `Check your connection and try again.`
- Retry action calls the existing fetch path
- Do not show placeholder `GroupsResponseModel` data as content

### State exclusivity

Loading, content, empty, and error views must never overlap.

Switching the segment must immediately recompute the correct content or empty state without refetching all groups.

---

## Component ownership

### `GroupsViewController`

Owns:

- Navigation avatar/title/add button
- Current selected list segment
- Table and its header
- Owned/shared filtering
- Loading/content/empty/error switching
- Existing fetch
- Existing create action
- Existing selection navigation
- Supplying member profiles to visible cells without changing the backend

It must not manually lay out the inside of each card.

### `ListsHeaderView`

Owns:

- Subtitle
- Rounded two-option segment container
- Selected styling and pink underline
- Selection callback
- Accessibility selected state

It must not fetch groups or decide which groups are shown.

### `GroupCell`

Owns:

- Card surface
- Cover image/fallback
- Name and optional description
- Available metadata
- Avatar cluster
- Membership badge
- Right arrow
- Highlight state
- Reuse cleanup

Use one focused configure entry point based on `GroupModel`, the logged-in username, and any already-fetched member profiles. Do not add a new presentation architecture solely for this page.

Member profile loading must be coordinated by the controller:

- Build one deduplicated set of active-member usernames from the currently displayed lists.
- Fetch that set in one `UsersDataController.fetchUsersWithImages` operation.
- Reconfigure or reload affected visible rows after profiles arrive.
- Do not start a separate duplicate profile request from every cell.

### Optional small reusable views

Small page-local views are acceptable if they simplify the cell:

- `ListMemberAvatarsView`
- `ListEmptyStateView`
- `CreateListCell`

Do not split every label into its own file.

---

## Reuse requirements

In `GroupCell.prepareForReuse()`:

- Cancel the image-loading task.
- Reset expected `groupID`.
- Clear the cover image.
- Restore the intentional soft-pink fallback.
- Clear name and description.
- Hide description.
- Clear and hide optional metadata.
- Remove/reset member avatar views.
- Reset badge text, icon, and visibility.
- Reset right arrow and highlighted alpha.
- Prevent old asynchronous images from being applied after reuse.

The configure method must set every visible and hidden state every time.

---

## Accessibility

- Add button label: `Create a new list`
- Profile button label: `Open profile`
- Segment buttons expose selected state and labels
- Right arrow is hidden from accessibility
- Use at least `Layout.touchTargetSize` for interactive controls
- Do not rely on pink alone; active segment also has semibold text, a white surface, and selected accessibility state
- Prefer Dynamic Type-compatible text styles if consistent with current app conventions; otherwise preserve the existing `Fonts` tokens and verify no clipping at larger accessibility sizes

---

## Implementation sequence

### Step 1 — Page shell and navigation

- Set white screen/table backgrounds.
- Replace `"Nav Bar"` with `My Lists`.
- Load the real current-user avatar.
- Replace the standard add item with the 40-point pink add button.
- Update the tab title to `Lists` and selected tint to pink.
- Preserve existing actions.

**Checkpoint:** Header and tab match the mockup before card work begins.

### Step 2 — Intro and custom segment

- Restyle `ListsHeaderView`.
- Add the exact subtitle.
- Build the 50-point rounded segment.
- Preserve current index callback and filtering.
- Verify active/inactive colors and underline geometry.

**Checkpoint:** Both tabs switch correctly and no blue selection remains.

### Step 3 — Real-data list card

- Redesign `GroupCell` as the rounded preview card.
- Bind real name, description, creator, member count, and group image.
- Add intentional image fallback.
- Add right arrow and native highlight.
- Hide unavailable item count and privacy.

**Checkpoint:** One and multiple real lists render without raw implementation fields.

### Step 4 — Member avatars

- Gather unique active-member usernames for the selected tab.
- Fetch them as one deduplicated batch using existing `UsersDataController`.
- Show up to three loaded active-member avatars.
- Hide avatars cleanly while absent or unavailable.
- Guard against reused-cell image leakage.

**Checkpoint:** Scrolling rapidly never swaps cover or member images between lists.

### Step 5 — Creation card

- Add the creation card after My Lists content.
- Route it to the same create action as the header button.
- Keep it absent from Shared With Me.

### Step 6 — Loading, empty, and error

- Add mutually exclusive states.
- Add exact My Lists and Shared With Me empty copy.
- Add retry behavior.
- Prevent placeholder fallback models from appearing as real lists.

### Step 7 — Final visual pass

- Compare directly with the supplied mockup.
- Tune only component-specific geometry needed for the match.
- Check 4-point spacing consistency.
- Confirm three cards are reasonably visible on a standard iPhone.
- Confirm pink is limited to selected/action states.

---

## Test matrix

### Data

- My Lists: zero, one, and multiple lists
- Shared With Me: zero, one, and multiple lists
- List with image
- List with missing/invalid image
- List with empty description
- List with known legacy placeholder description
- Long one-line and two-line names
- One active member
- More than one active member
- More than three active members
- Member profile fetch failure
- Duplicate usernames across multiple lists
- API failure
- Decode failure/default response

### Interaction

- Header add opens the current create flow
- Creation card opens the same create flow
- Segment switches without unnecessary API refetch
- List tap opens the correct `IndividualGroupViewController`
- Ownership flag remains correct
- Retry uses the current groups fetch
- Profile button preserves its current action
- Lists tab remains selected and pink

### Reuse

- Scroll quickly through several lists
- Switch tabs while images load
- Return from a list detail after data changes
- Create a list and confirm the index refreshes
- Confirm a selected create-list image is not falsely expected to appear until the separate upload gap is addressed
- Ensure old images, badges, and descriptions never appear in reused rows

### Devices

- One smaller iPhone simulator (for example iPhone SE size)
- One larger iPhone simulator (for example current Pro Max size)
- Portrait orientation
- Verify safe-area and bottom-tab spacing
- Verify larger text settings do not overlap important controls

---

## Expected files

Primary changes:

- `App/Main/GroupsViewController.swift`
- `App/Main/Groups/cells/GroupCell.swift`
- `App/Main/Groups/Lists/Components/ListMasterHeader.swift`
- `Functions/Helpers/AppTabBarFactory.swift`

Possible small additions:

- `App/Main/Groups/Lists/Components/CreateListCell.swift`
- `App/Main/Groups/Lists/Components/ListEmptyStateView.swift`
- `App/Main/Groups/Lists/Components/ListMemberAvatarsView.swift`

Only if genuinely reusable:

- `Style/Buttons.swift`
- `Style/ImageStyle.swift`
- `Style/Fonts.swift`
- `Style/Colors.swift`

Do not edit:

- `Style/AllStyle.swift`
- Backend group models/endpoints for item counts or privacy
- `IndividualGroupViewController` navigation contract
- Storyboards solely for visual layout
- Old `Sort` UI as a design source

---

## Done when

- The page visually matches the supplied mockup in margins, proportions, type, colors, card density, and pink accent usage.
- The interface says **My Lists** and the tab says **Lists**.
- Header avatar, title, and pink add button are compact and aligned.
- Segment uses a soft-gray rounded surface with a white active state and thin pink underline.
- Real lists render as compact rounded cards.
- Real group images load; missing images use the intentional gift/list fallback.
- Raw group ID and group type are gone.
- Description, creator, member count, avatars, and badge only appear when supported by real data.
- Item count and factual privacy are omitted because the current index API does not provide them.
- Both empty states are complete.
- Loading and error states do not overlap content.
- Existing create, filter, navigation, and tab behavior still works.
- Cell reuse is clean under rapid scrolling and tab switching.
- No broad refactor or second style system was introduced.

---

## Visual review note

The written requirements above are precise enough to establish the implementation structure, but the actual image asset was not available in the workspace/message attachment during document creation.

Before the final polish checkpoint, place the mockup in this folder as:

`Doc/feature_lists_mock.png`

Then compare the running screen side by side and tune:

- Header vertical alignment
- Subtitle baseline and spacing
- Segment width/radius/underline
- Card height and outer margins
- Cover size and corner radius
- Text wrapping
- Footer/avatar/badge alignment
- Bottom safe-area spacing

The mockup wins over approximate measurements in this document when there is a visible discrepancy.
