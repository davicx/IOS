# Feature Navigation

## Navigation Bar Rule

Every primary screen uses the existing system `UINavigationBar` for its fixed, page-level header.

Do not add a custom top header view unless that header is page content intended to scroll with the screen.

The navigation bar:

- stays fixed above the content
- lets UIKit handle safe-area spacing
- allows tables and collections to scroll below it
- provides back navigation on pushed detail screens
- is configured by each screen through `navigationItem`

Use:

- `navigationItem.title`
- `navigationItem.titleView`
- `navigationItem.leftBarButtonItem`
- `navigationItem.rightBarButtonItem`

## Main App Structure

```text
UITabBarController
├── UINavigationController -> HomeViewController
├── UINavigationController -> GroupsViewController
├── UINavigationController -> Discover
└── UINavigationController -> Profile
```

Each primary tab should configure its own navigation bar contents.

Example configurations:

```text
HOME
[profile]       Kite logo       [add]

GROUPS
[profile]       Events          [add]

DETAIL
[back]          Event name      [menu]

SEARCH
[back]          Search          [filter]
```

## Fixed Navigation vs Scrolling Page Headers

Use the system navigation bar for fixed page navigation.

Use a table header for scrollable page content, such as:

- `EventsMasterHeader`
- `ListMasterHeader`
- filters
- segmented controls
- profile summary blocks

Example Groups structure:

```text
System navigation bar     <- fixed
EventsMasterHeader        <- scrolls with table
Event cells               <- scroll
```

## Current Observation

`GroupsViewController` configures its navigation item with a title, profile image, and add button.

`HomeViewController` is also inside a navigation controller but currently does not configure navigation items, so the navigation bar appears empty or less noticeable.

The Home storyboard includes a navigation controller and `AppTabBarFactory` also wraps Home in a navigation controller. Later, make sure one screen has one navigation-controller owner.

## Design Direction

Keep navigation simple and fixed initially.

Do not implement disappearing or collapsing navigation headers yet. First make every primary screen use a consistent navigation frame. Revisit large/collapsing header behavior only when a specific screen needs it.
