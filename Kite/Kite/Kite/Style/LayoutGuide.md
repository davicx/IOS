# Kite Style How To

Kite uses a small consumer-mobile design system.

The goal is not to create a large enterprise design system.
The goal is to keep the app visually consistent, compact, and easy to extend without every screen drifting in a different direction.

Kite should feel:

- clean
- content-first
- mostly white / black / gray
- restrained with brand color
- typography-led
- compact and modern
- friendly, not corporate

---

## Core Rule

**Before adding a new visual value, check `Colors`, `Fonts`, and `Layout`. Reuse an existing token when it fits. Add a new token only when the design genuinely requires a new visual role.**

---

## Two Layers

Kite styling uses two layers:

### 1. Tokens

Tokens define the visual vocabulary.

Examples:

- `Colors.primaryBlue`
- `Colors.primaryText`
- `Fonts.semibold16`
- `Layout.spacingMedium`
- `Layout.radiusSmall`

These are the raw reusable building blocks.

### 2. Semantic styles

Semantic styles define how Kite components use the tokens.

Examples:

- `Fonts.postUsernameFont`
- `Fonts.postCaptionFont`
- `Colors.postedAtTextColor`
- `Buttons.loginButtonStyle(button:)`
- `LabelStyle.postEventTitle(_:)`

These are component-facing names that keep the app readable.

Rule:

**Tokens define the visual vocabulary. Semantic styles define how Kite components use that vocabulary.**

---

## Style Folder Responsibilities

### `Colors.swift`

Contains:

- base color tokens
- semantic color aliases

Examples:

- token: `primaryBlue`
- token: `primaryText`
- semantic alias: `buttonLoginBackground`
- semantic alias: `postedAtTextColor`

Use `Colors.swift` when choosing a color.

Do not define raw hex or custom `UIColor(red:)` values in feature components unless testing temporarily.

### `Fonts.swift`

Contains:

- base font tokens
- semantic component font aliases

Examples:

- token: `regular14`
- token: `semibold16`
- semantic alias: `postCaptionFont`
- semantic alias: `profileFullNameFont`

Use `Fonts.swift` when choosing typography.

Component-specific font names are encouraged even when several resolve to the same base token.

For example:

- `postUsernameFont`
- `commentUsernameFont`
- `groupNameFont`

may all point to the same underlying token.

That is useful abstraction, not duplication.

### `Layout.swift`

Contains shared layout tokens:

- spacing
- corner radius
- icon sizes
- avatar sizes
- border widths

This file exists to reduce arbitrary layout values.

Use `Layout.swift` before introducing new hard-coded spacing or size numbers.

### `Style.swift`

Contains reusable styling helpers for UI elements.

Examples:

- `LabelStyle`
- `TextFieldStyle`
- `ViewStyle`

Use this when multiple components style the same kind of UIKit view in the same way.

### `Buttons.swift`

Contains shared button appearances.

Examples:

- login button
- friend state buttons
- generic filled/gray buttons
- link buttons

If a button pattern appears in more than one place, move it here.

### `ImageStyle.swift`

Contains reusable image treatments.

Examples:

- avatar image styling
- post image styling
- background image styling

### `Dividers.swift`

Contains divider components and divider-like shared visual structure.

Use when a divider pattern repeats.

---

## Typography Rules

Kite should use one primary font family with a small set of sizes and mostly regular + semibold.

### Base roles

- `title`
- `heading`
- `body`
- `caption`

### Typical use

- `title`: page titles
- `heading`: group names, important names, section headings
- `body`: main content, posts, comments, primary button text
- `caption`: timestamps, metadata, helper text

### Weight guidance

Prefer:

- regular
- semibold

Use bold only when there is a clear reason.

### Component examples

- post username -> body semibold
- post text -> body regular
- post timestamp -> caption regular
- comment username -> body semibold
- comment text -> body regular
- group name -> heading semibold
- page title -> title semibold/bold
- button text -> body semibold

Rule:

**Do not choose a new font for every component. Start from the existing type roles.**

---

## Color Rules

Most of Kite should remain neutral.

### Preferred roles

#### Background

- `background`
- `surface`

#### Text

- `textPrimary`
- `textSecondary`
- `textTertiary`

#### Structure

- `border`
- `divider`

#### Brand

- `primary`
- `accent`

#### State

- `success`
- `danger`

Kite blue and pink are part of the app identity, but they should be used intentionally.

Rule:

**Most UI should be white + black + gray. Brand colors should emphasize interaction or priority, not decorate every surface.**

Examples:

- timestamp -> `textSecondary` or `textTertiary`
- divider -> `divider`
- card background -> `surface`
- main CTA -> `primary`
- supportive accent action -> `accent`

---

## Layout Rules

Kite uses a 4-point spacing system.

Preferred values:

- 4
- 8
- 12
- 16
- 24
- 32

These should become shared layout tokens in `Layout.swift`.

### Typical usage

- icon to text -> 8
- username to timestamp -> 4
- title to subtitle -> 4
- content block padding -> 12 or 16
- screen horizontal inset -> 16
- section separation -> 24
- major separation -> 32

Rule:

**Avoid arbitrary spacing values unless there is a specific visual reason.**

---

## Shape Rules

Kite should use a small shape vocabulary.

### Corner radius

Use a small set of standard radii, for example:

- small
- medium
- large
- circle

### Icons

Use a small set of icon sizes, for example:

- small
- normal
- large

### Avatars

Use a small set of avatar sizes, for example:

- small
- normal
- large

### Borders

Use a small set of border widths and border colors.

Rule:

**Do not let every component invent its own radius, icon size, avatar size, or border treatment.**

---

## Building a New Component

When creating a new component:

1. Start with layout and hierarchy.
2. Use spacing from `Layout.swift`.
3. Use fonts from `Fonts.swift`.
4. Use colors from `Colors.swift`.
5. If repeated label styling appears, move it into `LabelStyle`.
6. If repeated image styling appears, move it into `ImageStyle`.
7. If repeated button styling appears, move it into `Buttons.swift`.
8. Only add a new token if an existing token truly does not fit.

Rule:

**When something looks wrong, first adjust spacing, alignment, hierarchy, or emphasis. Do not immediately invent a new color, font, radius, or border.**

---

## Migration Strategy

Do not attempt a broad visual migration all at once.

Preferred order:

1. write the rules
2. add `Layout.swift`
3. migrate 2-3 visible components
4. evaluate whether the system is actually helping
5. continue gradually as files are touched

Good first migration targets:

- `PostContent`
- `PostCaption`
- profile name / username / info counts
- friend buttons
- group headers

These are visible, compact, and already partly tokenized.

---

## Practical Kite Rule

Kite uses one typography system, one color system, a 4pt spacing grid, and a small set of standard shapes. New UI should reuse these tokens before introducing new visual values.

The app should feel consistent because the same design vocabulary is being reused, not because every screen was redesigned at once.
