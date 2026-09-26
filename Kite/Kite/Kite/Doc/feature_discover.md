# Feature: Wishlist Discover

**Status:** Plan only — do not implement yet  
**Scope:** `IOS/Kite/Kite/Kite`  
**Screen:** Existing `DiscoverViewController` in the Discover tab  
**Framework:** UIKit  
**Visual source:** Supplied Browse and Search mockups

---

## Goal

Replace the current basic friend-search table with one polished Discover screen that has two in-place states:

1. **Browse**
   - Items is selected initially.
   - Items shows four curated products in a two-column grid.
   - People shows four real friends.
   - Lists shows four real Wishlist lists the signed-in user owns or belongs to.

2. **Search**
   - Begins when the trimmed query has at least two characters.
   - Entering Search removes the category highlight.
   - Search shows matching visible People and accessible Lists in separate sections.
   - Items are not searched in the MVP.
   - Tapping any category exits Search and returns to that category’s default Browse recommendations.
   - Clearing the query restores the last Browse category immediately.

Search changes the content inside `DiscoverViewController`. It must not push a second search controller.

---

## Locked product behavior

### Browse

- Discover opens with **Items** selected.
- The Items screen contains:
  - Discover title.
  - Search field.
  - Items / People / Lists category control.
  - “Discover something fun.”
  - Four curated item cards.
- Do not show “See all” beside the four curated items.
- Do not show People or Lists content below the item grid. Each Browse category shows only its corresponding content.
- Empty People shows a friendly no-friends state.
- Empty Lists shows a friendly no-lists state.

### Search

- Trim whitespace before deciding whether to search.
- Zero or one meaningful character does not call the API.
- One character shows: “Keep typing to search people and lists.”
- Two or more characters starts a 300 ms debounced search.
- Search mode has no highlighted category.
- Search returns visible users, not only friends.
- Search returns only lists the signed-in user may view.
- Tapping Items, People, or Lists clears the query, exits Search, highlights that category, and shows its default Browse recommendations.
- Clear restores `lastBrowseCategory`.
- Search result count is the combined number of currently displayed People and Lists.
- Hide a Search section when it has no rows.
- A zero-result Search says:
  - `No people or lists found for “{query}”`
- A stale response for an older query must never replace newer results.
- If one Search request fails, keep the successful section and show a retry state for the failed section.

### Navigation and actions

- Person row:
  - Instantiate `FriendProfileViewControllerID` from `Profile.storyboard`.
  - Set `FriendProfileViewController.friend`.
  - Push on the Discover navigation controller.
- List row:
  - Instantiate `IndividualGroupViewController` from `Groups.storyboard`.
  - Set `groupID`.
  - Derive and set `currentUserOwnsGroup`.
  - Push on the Discover navigation controller.
- Curated item `+`:
  - Ask which owned Wishlist should receive the item.
  - Convert the curated item into the existing `ItemDraft`.
  - Continue through the existing `ReviewItemViewController`.
  - Do not create a second item-submission implementation.
- Curated item card:
  - Do not pretend there is an item-detail screen if no destination exists.
  - For MVP, only the `+` is interactive unless an existing real item ID can open an established detail screen.

---

## Current implementation inspection

### Discover tab already exists

`Functions/Helpers/AppTabBarFactory.swift`

- Loads `Discover.storyboard`.
- Instantiates storyboard ID `DiscoverViewController`.
- Wraps it in its own `UINavigationController`.
- Uses the correct Discover tab position and `magnifyingglass` symbol.
- Applies `Colors.primaryPink` to selected tab items.

Do not create another tab bar, reorder tabs, or replace the existing navigation controller.

### Existing Discover screen

`App/Main/Discover/DiscoverViewController.swift`

The current controller:

- Uses a full-screen `UITableView`.
- Places a `UISearchBar` in the table header.
- Searches only active friends.
- Starts searching at two characters.
- Reloads basic text cells.
- Has no browse state, category control, lists, curated items, category-aware search, cancellation, loading UI, or navigation.

Replace this controller’s implementation in place. Keep its class name and storyboard identifier.

The current app has no active `UICollectionView` implementation to reuse. The Discover collection view, compositional layout, and diffable data source are intentional new UIKit infrastructure required by the two-column product design; do not force the grid into nested table views.

### Existing storyboard

`Storyboards/Discover.storyboard`

- Contains the existing `DiscoverViewController` scene.
- The scene is effectively an empty host view.

Keep the scene because `AppTabBarFactory` instantiates it. Build the new screen programmatically inside that scene.

### Existing People data

`Functions/Controllers/FriendDataController.swift`

- `fetchFriends()` loads the current user’s relationships.
- `splitFriendsByStatus().friends` provides accepted friends.
- `User` already exposes stable `userID`, `userName`, `displayName`, image URL, and `profileImage`.

Use this source for the four Browse friends.

`Functions/Controllers/UsersDataController.swift`

- Caches users.
- Fetches profiles and profile images.
- Supports batch user/image loading.

Reuse it for converting search DTOs into navigable `User` values and for image loading. Do not create another user cache.

### Existing Lists data

`Functions/Controllers/GroupDataController.swift`

- `getGroups` loads lists accessible to the signed-in user.
- `groups` contains owned and member lists.
- `currentUser` is available for ownership checks.

For Browse Lists:

- Filter to `groupType.lowercased() == "wishlist"`.
- Include owned and shared/member records.
- Return at most four.
- Prefer a stable order from the server; if none is guaranteed, preserve response order.

`GroupModel` currently provides:

- `groupID`
- `groupName`
- `groupDescription`
- `groupType`
- `groupImage`
- `createdBy`
- Active and pending members

It does not provide an item count. Do not fabricate one.

### Existing destinations

Person:

- `App/Main/Profile/Friends/FriendProfileViewController.swift`
- Storyboard ID: `FriendProfileViewControllerID`
- Input: `friend: User`

List:

- `App/Main/IndividualGroup/IndividualGroupViewController.swift`
- Input: `groupID` and `currentUserOwnsGroup`
- Existing navigation example: `GroupsViewController.tableView(_:didSelectRowAt:)`

Reuse those destinations exactly.

### Existing add-item flow

The app currently starts item creation only from a known list:

- `IndividualGroupViewController.newGroupPostButton()`
- `NewItemViewController`
- Paste / Photo / Manual
- `ReviewItemViewController`
- `PostLogic.shared.createItemPost`

There is no global choose-list screen today. Discover therefore needs a small list-selection step, but it must feed the selected list and a prefilled `ItemDraft` into the existing `ReviewItemViewController`. It must not duplicate `PostLogic` or call the create endpoint itself.

### Existing image loading

- `ImageCacheManager` in `Functions/userFunctions.swift` caches remote user images.
- `ImageFunctions` provides general URL loading and fallback behavior.
- `GroupCell` already has reuse-aware asynchronous list cover loading.

`DiscoverUser`, `DiscoverList`, and `DiscoverItem` must cancel their image tasks when reused and verify the represented ID before assigning an image.

### Existing design tokens

Reuse:

- `Colors.primaryPink`
- `Colors.primaryGrayText`
- `Colors.subtleGrayText`
- `Colors.screenBackground`
- `Colors.newItemCardBorder`
- Existing `Fonts` and `Layout` values where they match

Use the existing tokens in `IOS/Kite/Kite/Kite/Style` (`Colors`, `Fonts`, `Layout`, `Style`, `Buttons`, and `ImageStyle`). Add a Style token only when an existing one does not fit. Do not create a separate `DiscoverStyle.swift`.

### Existing search API warning

`SearchAPI.searchFriends` calls:

```text
GET /search/user/{username}/string/{query}/
```

That endpoint searches only active friends. It cannot satisfy the broader People search requirement.

The backend also currently exposes:

```text
POST /search/users/
POST /search/group/
POST /search/all/
```

Those routes are not yet safe contracts for this feature:

- The group search currently searches all non-deleted groups without enforcing list visibility.
- The search routes do not currently apply the imported authentication middleware.
- Global list results can therefore include records the signed-in user should not see.

Do not ship Discover against unrestricted group search. The backend must provide an authenticated, visibility-filtered contract first. Backend implementation belongs to a separate API task; this iOS feature consumes the approved contract.

---

## Screen architecture

Use one `UICollectionView` with a diffable data source.

```text
DiscoverViewController
├── titleLabel
├── DiscoverSearchBar
├── DiscoverTabBar          Items | People | Lists
└── collectionView
    ├── DiscoverItem        Browse Items
    ├── DiscoverUser        Browse People and Search People
    ├── DiscoverList        Browse Lists and Search Lists
    └── Loading/empty/error message
```

`DiscoverTabBar` is the category control inside this screen. It is not the app’s bottom tab bar in `AppTabBarFactory`.

Keep the title, `DiscoverSearchBar`, and `DiscoverTabBar` above the collection view. Only the results area scrolls. Browse and Search reuse `DiscoverUser` and `DiscoverList`. Search does not get its own row views.

### Component structure

Each new view is a `UIView` and uses the existing section order:

```swift
//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS
```

| Component | Responsibility |
| --- | --- |
| `DiscoverSearchBar` | Search icon, text field, and clear button. |
| `DiscoverTabBar` | Items, People, and Lists. One selection in Browse. No selection in Search. |
| `DiscoverItem` | Featured product card, image, title, category, and `+` action. |
| `DiscoverUser` | Person row for Browse People and Search People. |
| `DiscoverList` | List row for Browse Lists and Search Lists. |

`DiscoverViewController` owns screen state, section titles, and loading, empty, and error copy. Those states do not become separate components.

### State

```swift
enum DiscoverCategory: Hashable {
    case items
    case people
    case lists
}

enum DiscoverContentState: Equatable {
    case browsing(category: DiscoverCategory)
    case searching(query: String)
}
```

Rules:

- `lastBrowseCategory` starts as `.items`.
- Entering Search keeps `lastBrowseCategory` internally but clears the visual category selection.
- Tapping any category during Search clears the query and enters `.browsing(category:)` for the tapped category.
- A category is selected only in Browse mode.
- Clearing search restores `.browsing(category: lastBrowseCategory)`.

### Diffable identifiers

```swift
enum DiscoverSection: Hashable {
    case featuredItems
    case browsePeople
    case browseLists
    case searchPeople
    case searchLists
    case message
}

enum DiscoverEntry: Hashable {
    case item(id: String)
    case person(id: Int)
    case list(id: Int)
    case message(id: String)
}
```

IDs include the record type so a person and list with the same numeric ID cannot collide.

---

## Planned files

### New iOS files

`App/Main/Discover/DiscoverDataController.swift`

- Own Browse and Search loading.
- Load four accepted friends through `FriendDataController`.
- Load four accessible Wishlist lists through `GroupDataController`.
- Run debounced search.
- Cancel previous search tasks.
- Reject stale results with a monotonically increasing request generation.
- Preserve separate People and Lists loading/error states.
- Expose presentation-ready results to `DiscoverViewController`.

`API/DiscoverAPI.swift`

- Follow the existing `SearchAPI` / `GroupsAPI` class convention.
- Use `URLSession` async requests.
- Encode query values with `URLComponents`; never interpolate raw search text into a URL path.
- Decode the approved authenticated People and Lists search responses.
- Return transport and decode failures instead of fabricated sample data.

`API/Models/Discover/DiscoverModels.swift`

- `DiscoverPersonModel`
- `DiscoverListModel`
- Search response envelopes
- Explicit coding keys matching the approved API
- Stable IDs and only fields needed by the UI/navigation

`App/Main/Discover/DiscoverModels.swift`

- `DiscoverCategory`
- `DiscoverContentState`
- `DiscoverSection`
- `DiscoverEntry`
- `DiscoverFeaturedItem`
- Presentation/error/loading state

`App/Main/Discover/Components/DiscoverSearchBar.swift`

- Search icon, text field, and trailing clear button.
- Placeholder: `Search people or lists`.

`App/Main/Discover/Components/DiscoverTabBar.swift`

- Items, People, and Lists buttons.
- Shows exactly one selected category in Browse and no selected category in Search.
- Pink selected background.
- Accessibility labels and selected traits.
- Does not replace `AppTabBar`.

`App/Main/Discover/Components/DiscoverItem.swift`

- Two-column product card.
- Aspect-fit product image.
- Name and category.
- Independent circular `+` target.
- Reuse-safe configuration.

`App/Main/Discover/Components/DiscoverUser.swift`

- Circular avatar.
- Display name and username.
- Optional public-list count only when the API provides it.
- Full-row selection and trailing chevron.
- Used by Browse People and Search People.

`App/Main/Discover/Components/DiscoverList.swift`

- Rounded-square cover.
- List name.
- Owner.
- Optional item count only when returned by the API.
- Full-row selection and trailing chevron.
- Used by Browse Lists and Search Lists.

`App/Main/Discover/DiscoverListPickerViewController.swift`

- Displays owned Wishlist lists only.
- Lets the user choose where the curated item will be added.
- Builds a prefilled `ItemDraft`.
- Opens the existing `ReviewItemViewController`.
- Does not submit items itself.

`KiteTests/DiscoverStateTests.swift`

- State transitions.
- Query trimming/minimum length.
- Generation-based stale-response rejection.
- Browse-to-Search transitions and category-tap Search exit behavior.
- Partial failure behavior.

`KiteUITests/DiscoverUITests.swift`

- Basic Browse/Search/category/clear/navigation smoke tests where stable test data is available.

### Changed iOS files

`App/Main/Discover/DiscoverViewController.swift`

- Replace the current table/search implementation.
- Build the fixed header and collection view.
- Configure diffable data source and compositional layout.
- Render Browse and Search snapshots.
- Route taps to existing profile/list/add-item flows.
- Dismiss keyboard on scroll and destination navigation.

`Storyboards/Discover.storyboard`

- Keep the existing scene and storyboard identifier.
- Remove any obsolete layout assumptions only if Interface Builder contains them.
- Do not add the new UI as storyboard outlets; the screen remains programmatic.

`Kite.xcodeproj/project.pbxproj`

- Add all new Swift files to the Kite target.
- Add test files to the correct test targets.

`Assets.xcassets`

- Add four approved product image sets only after source images are supplied or approved.
- Do not crop product images from the supplied screen mockup.

### Files reused without redesign

- `Functions/Helpers/AppTabBarFactory.swift`
- `Functions/Controllers/FriendDataController.swift`
- `Functions/Controllers/GroupDataController.swift`
- `Functions/Controllers/UsersDataController.swift`
- `Functions/Classes/User.swift`
- `App/Main/Profile/Friends/FriendProfileViewController.swift`
- `App/Main/IndividualGroup/IndividualGroupViewController.swift`
- `App/Main/Post/AddItem/ItemDraft.swift`
- `App/Main/Post/AddItem/ReviewItemViewController.swift`
- `Functions/Logic/PostLogic.swift`
- `Functions/userFunctions.swift`
- `Functions/imageFunctions.swift`
- `Style/Colors.swift`
- `Style/Fonts.swift`
- `Style/Layout.swift`

---

## Data contracts

### Curated items

```swift
struct DiscoverFeaturedItem: Hashable {
    let id: String
    let title: String
    let category: String
    let imageAssetName: String
    let productURL: URL?
    let price: String?
    let defaultPostText: String?
}
```

MVP records:

1. `discover_1` — Super Mario RPG — Video Games
2. `discover_2` — Zelda: Echoes of Wisdom — Video Games
3. `discover_3` — Botanical Garden — LEGO
4. `discover_4` — Retro Camera — LEGO

Each item needs:

- A stable local ID.
- Its corresponding approved image in `Assets.xcassets`.
- Enough data to create a valid `ItemDraft`.
- A local `UIImage` because `ReviewItemViewController` currently requires a photo before submission.

Do not activate `+` until all required draft fields and the image are available.

### Browse People

Source:

```text
FriendDataController.fetchFriends()
→ splitFriendsByStatus().friends
→ first four
```

### Browse Lists

Source:

```text
GroupDataController.getGroups()
→ accessible groups for current user
→ groupType == wishlist
→ first four
```

### Required secure Search API

Preferred contract:

```text
GET /discover/search/people?q={query}
GET /discover/search/lists?q={query}
```

Both endpoints must:

- Require the signed-in session.
- Validate and trim `q`.
- Enforce a minimum query length server-side.
- Search all active users visible to the signed-in user, not only friends.
- Return only lists the user may view.
- Exclude deleted records.
- Return stable IDs.
- Return pagination metadata even if MVP requests only the first page.

People fields:

```text
userID
userName
firstName
lastName
userImage
publicListCount (optional)
```

List fields:

```text
groupID
groupName
groupImage
createdBy
groupType
itemCount (optional)
currentUserOwnsGroup
```

The existing active-friend search may remain for other screens. Discover should not repurpose its `FriendSearchModel` because it lacks a stable user ID and is limited to existing friends.

There are duplicate `FriendSearchModel` and `FriendSearchResponseModel` files under `API/Models/Search` and `API/Models/Friends`; only the compiled target copies should remain authoritative. Do not add the dormant duplicates to the Xcode target or base the new Discover DTOs on ambiguous duplicate types.

---

## Search concurrency

`DiscoverDataController` should keep:

```swift
private var searchTask: Task<Void, Never>?
private var searchGeneration = 0
```

On query change:

1. Cancel `searchTask`.
2. Increment `searchGeneration`.
3. Capture the generation and normalized query.
4. Sleep for approximately 300 ms.
5. Exit if cancelled.
6. Request People and Lists concurrently.
7. Before publishing, confirm:
   - Task is not cancelled.
   - Captured generation is still current.
   - Captured query still equals the visible normalized query.

One failed request must not discard valid results from the other request.

---

## Layout specifications

### Page shell

- White/light semantic background.
- 16 pt horizontal margin.
- Title approximately 34 pt bold.
- Title pinned below the safe area.
- Existing tab bar remains visible.
- Collection view ends at the view safe area above the tab bar.

### DiscoverSearchBar

- Approximately 50 pt high.
- Capsule radius approximately 25 pt.
- `magnifyingglass` leading symbol.
- Placeholder: `Search people or lists`.
  - This is more honest than claiming item search works.
- Trailing circular `xmark` only when nonempty.
- Search return key dismisses keyboard.

### DiscoverTabBar

- Full content width.
- Approximately 40 pt high.
- Three equal buttons.
- Pale gray outer background.
- Pale pink selected background.
- Has one selected button in Browse and no selected button in Search.

### DiscoverItem

- Two columns.
- 8–12 pt inter-item spacing.
- White cards with 1 pt border and 14–16 pt radius.
- Image uses `.scaleAspectFit`.
- Circular outlined `+`, at least 44 × 44 pt tappable area.
- Stable card heights while images load.

### DiscoverUser and DiscoverList

- Full-width cards.
- 1 pt light border.
- Approximately 14 pt radius.
- Minimum 80 pt row height.
- Person image: circular, approximately 54 pt.
- List image: rounded square, approximately 56 pt.
- Trailing `chevron.right`.
- Entire card is selectable.

### Search sections

```text
Search results
2 results for “sam”

PEOPLE
[ person row ]

LISTS
[ list row ]
```

- Uppercase muted section labels.
- Hide empty sections.
- Count only displayed records for MVP.

### Accessibility

- Dynamic Type-compatible labels.
- Do not set fixed row heights that clip larger text.
- Add item button label includes the product:
  - `Add Super Mario RPG to a list`
- Category buttons expose selected traits.
- Search results announce type and primary label.
- Respect Reduce Motion when applying diffable snapshots.

---

## Build order

1. Confirm approved product image assets and curated item metadata.
2. Establish authenticated all-visible-user and visibility-filtered Lists search contracts.
3. Add Discover API DTOs and `DiscoverAPI`.
4. Build `DiscoverDataController` with cancellation and stale-result protection.
5. Replace the current Discover table with the fixed header and collection view.
6. Build `DiscoverSearchBar`, `DiscoverTabBar`, `DiscoverItem`, `DiscoverUser`, and `DiscoverList`.
7. Implement Browse Items, People, and Lists.
8. Implement grouped People and Lists Search.
9. Connect profile and list navigation.
10. Add the owned-list picker and hand off to `ReviewItemViewController`.
11. Add unit/UI tests.
12. Test on a small iPhone, large Dynamic Type, slow networking, partial API failure, and rapid typing.

---

## Verification checklist

- Discover remains the existing third tab.
- Discover opens with Items selected.
- Four approved product cards appear in a two-column grid.
- No item-catalog See all link is shown.
- Items shows no People or Lists content.
- People displays at most four accepted friends.
- Lists displays at most four accessible Wishlist lists.
- Two-character search starts after the debounce.
- Search clears the category highlight and shows grouped People and Lists results.
- People Search can return visible users who are not among the four Browse friends.
- Tapping a category during Search clears the query and restores that category’s default Browse recommendations.
- Clearing search restores the previous Browse category.
- Slow stale responses cannot overwrite the latest query.
- A failure in one Search section does not erase valid results from the other.
- Person rows open `FriendProfileViewController`.
- List rows open `IndividualGroupViewController`.
- Item `+` chooses an owned list and reaches `ReviewItemViewController`.
- Rapid `+` taps cannot create duplicate presentations or submissions.
- Keyboard dismissal, empty states, errors, and large text remain usable.
- No private or inaccessible list can appear in Search.

---

## Remaining implementation prerequisite and decision

1. **Search API work:** Add authenticated all-visible-user search and visibility-filtered Lists search. The current global group search is not safe to ship.
2. **Optional counts:** Decide whether the backend should return public-list counts for People and item counts for Lists. If not, the UI will omit those lines rather than invent values.

---

## Definition of done

Discover follows the supplied visual style, keeps Browse content category-specific, searches all visible users and accessible lists in a distinct unselected Search state, restores default Browse recommendations when a category is tapped, opens existing destinations, and routes curated item additions through the existing item review/submission flow without exposing inaccessible data or creating duplicate networking/navigation systems.
