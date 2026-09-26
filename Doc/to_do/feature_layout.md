# Feature Layout

## Layout Token Rule

`Layout.swift` should hold named layout values.

`PostHeader.swift` should apply those values to constraints.

This follows the same pattern as the existing font and color system:

```text
Fonts.postHeaderEventTitleFont
Colors.postHeaderEventTitleTextColor
Layout.postHeaderImageSize
```

The component combines those tokens to create the final UI.

## PostHeader First Test

Start by moving only PostHeader layout values into `Layout.swift`.

Suggested tokens:

```swift
Layout.postHeaderTextLineSpacing
Layout.postHeaderHeight
Layout.postHeaderHorizontalInset
Layout.postHeaderImageSize
Layout.postHeaderImageTextSpacing
Layout.postHeaderMenuIconSize
Layout.postHeaderMenuTapSize
Layout.postHeaderTextMenuSpacing
```

Suggested initial values:

```text
postHeaderTextLineSpacing: 2
postHeaderHeight: 52 or 56
postHeaderHorizontalInset: 12
postHeaderImageSize: 40
postHeaderImageTextSpacing: 8
postHeaderMenuIconSize: 24
postHeaderMenuTapSize: 44
postHeaderTextMenuSpacing: 8
```

The `2` point line spacing is an intentional typography exception. The 4-point grid remains the default for component layout, but the event title and event time can need tighter optical spacing.

## Example Usage

```swift
headerTextStackView.spacing = Layout.postHeaderTextLineSpacing

heightAnchor.constraint(
    equalToConstant: Layout.postHeaderHeight
)

headerGroupImageView.leadingAnchor.constraint(
    equalTo: leadingAnchor,
    constant: Layout.postHeaderHorizontalInset
)

headerGroupImageView.widthAnchor.constraint(
    equalToConstant: Layout.postHeaderImageSize
)

headerGroupImageView.heightAnchor.constraint(
    equalToConstant: Layout.postHeaderImageSize
)

headerTextStackView.leadingAnchor.constraint(
    equalTo: headerGroupImageView.trailingAnchor,
    constant: Layout.postHeaderImageTextSpacing
)

headerGroupMenuIcon.widthAnchor.constraint(
    equalToConstant: Layout.postHeaderMenuIconSize
)
```

## Naming Guidance

Use descriptive component-specific layout names first:

```text
postHeaderImageSize
postHeaderMenuIconSize
postHeaderTextLineSpacing
```

Do not generalize values too early.

If multiple components later use the same visual value for the same purpose, consolidate it into a shared token then.

For example:

```text
PostHeader uses postHeaderImageSize
PostCaption uses postCaptionUserImageSize
```

Only after repeated use is clear should Kite consider a shared avatar-size token.

## Current PostHeader Typography Pair

```text
Fonts.postHeaderEventTitleFont
Colors.postHeaderEventTitleTextColor

Fonts.postHeaderEventTimeFont
Colors.postHeaderEventTimeTextColor
```

PostHeader applies each font/color pair directly to its corresponding label.

## First Scope

When implementing the first Layout token test:

```text
Add:    Style/Layout.swift
Modify: PostHeader.swift
```

Do not change other components until the PostHeader spacing test looks right.
