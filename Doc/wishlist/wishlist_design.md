# Wishlist Design

**Status:** Ideas only. Do not implement yet.  
**Scope:** Polish the existing Wishlist app. Do not redesign it.

The bones are good: white space, straightforward navigation, big imagery, and the pink/red accent. Login feels clean because it only has a few elements. Inside the app, font sizes, grays, borders, button shapes, spacing, and icon treatments were designed screen by screen. That is a polish problem.

The internal app should feel like **the login screen grew into a full application**: large image, simple fields, one obvious action, quiet secondary actions. Do not decorate the login page to match the busier screens.

---

## Approach

Start with what repeats. Do not start with “redesign Profile.”

1. Colors
2. Typography
3. Buttons
4. Text fields
5. Cards
6. Navigation / header
7. Tab bar
8. Post cell
9. Profile components
10. List components

Each time a reusable piece improves, several screens get quieter.

---

## 1. Typography

These treatments exist today and do not feel like one system:

- `Gifts I want!`
- list description
- `davey`
- `22 days ago`
- item title
- price
- description
- Profile
- David Vasquez
- `@davey`
- Posts / Groups / Friends
- About Me
- helper text

Define **five text styles** for the whole app:

| Style | Approx. use |
|---|---|
| **Page Title** | 20–22pt semibold/bold |
| **Section Title** | 17–18pt semibold |
| **Body** | 16–17pt regular |
| **Secondary** | 14–15pt regular, secondary gray |
| **Small** | 12–13pt regular |

Then stop choosing font sizes inside individual views.

Later this can be named:

```swift
WishlistTypography.pageTitle
WishlistTypography.sectionTitle
WishlistTypography.body
WishlistTypography.secondary
WishlistTypography.small
```

`Fonts.swift` already has semantic names (`listNameFont`, `itemNameFont`, `postCaptionFont`, `profileFullNameFont`). The sizes underneath still drift: list names are 18 semibold, item names 16 semibold, captions 14 regular, timestamps 12 regular, profile counts 18 semibold, the new-item intro is 28 bold, and Discover titles are 34 and 22 bold set locally. Map the existing names onto the five styles instead of adding more sizes.

---

## 2. Colors

Keep the pink/red. Stop mixing it with Apple blue.

Today the accent splits:

**Wishlist pink** (`Colors.primaryPink` `#FF2E7A`)

- selected tab (`AppTabBarFactory` tints the tab bar pink)
- Add on lists
- some friend actions

**A second pink** (`Colors.tikTokPink` `#EF3D57`)

- `buttonPinkStyle`
- the Purchase button

**Apple-like blue** (`Colors.primaryBlue` `#3797EF`)

- Log In
- Sign Up
- Forgot password
- Add Friend / current Friends
- Edit (About Me and Clothing)
- Log Out (system button, so it is blue by default)
- the dashed Add clothing note box
- the photo option on New Item
- link buttons

That is why the product feels partly custom and partly default UIKit.

Decide:

| Role | Color |
|---|---|
| **Primary accent** | one pink/red — pick `#FF2E7A` or `#EF3D57`, not both |
| **Primary text** | near black (`primaryGrayText` is already black) |
| **Secondary text** | one medium gray |
| **Background** | one very light gray |
| **Card** | white |
| **Border** | one subtle gray |

Text grays today are `#4D4D4D`, `#5A5A5A`, `#5F5F5F`, and `#737373`. They are too close to read as different roles. Collapse them to secondary and small.

Backgrounds today include white, `#F3F3F3`, `#F7F8F9`, `#F3F1EE`, and `#E5E5E5`. The warm item-detail gray (`#F3F1EE`) is the one that feels most like Wishlist. Use that family for screen background, and white for cards.

Move primary actions onto the Wishlist color: **+ Add Item**, **Edit**, **+**, the selected tab, **Log In**, **Sign Up**. Leave blue only if a specific control must stay a system link. Friend Accept can stay green. Delete can stay red.

---

## 3. Buttons

**Add Item** is the right direction. These are still six different actions:

- Add Item
- Invite Friends
- Share List
- Add clothing note
- Edit
- Log Out

Make three components.

### Primary

Pink/red filled. The thing you most want someone to do. **Add Item.** **Log In** belongs here too, once login leaves blue.

Today primary buttons do not match each other: login radius 5, friend and pink buttons radius 6, Purchase radius 8, empty-state Add radius 12, the lists add control radius 13.

### Secondary

White, thin border, dark text. **Invite Friends** and **Share List** are already this idea (`wishlistListActionButtonStyle`: white, `itemDetailDivider` border, dark text). They use radius 14, 12pt text, and very tight padding (`2` vertical, `8` horizontal). Bring height, radius, padding, and type in line with the other buttons.

### Text

No container. Accent-colored text. **Edit**, **Log Out**, **Forgot password**.

Today Edit and the login links are blue. Log Out is an unstyled system button. Point text buttons at the same pink.

Do not add a fourth shape for each new screen.

---

## 4. Cards

Profile stacks different containers: white header, gray content (`feedBackground`), white About Me, white Clothing card, and a loud **+ Add clothing note**.

`ClothingFooterAddNew` is a 76pt row, blue at 8% fill, blue title, and a dashed blue border at radius 16. It is louder than the profile information, and it is a secondary action.

One card:

```text
background: white
corner radius: 16
border: very subtle, or none
padding: 16
```

Turn **＋ Add clothing note** into a secondary or text action inside a normal row. The same dashed-blue treatment shows up again on Add Preference in the clothing sheet. Quiet both.

---

## 5. Corner radius

In use now: 1, 4, 5, 6, 8, 10, 12, 13, 14, 16, 19, 25, plus circles.

Use:

| Radius | Use |
|---|---|
| **8** | small controls |
| **12** | fields |
| **16** | cards |
| **pill** | only true pills |
| **circle** | avatars |

Text fields in the style dump are radius 5. Login is 5. Invite/Share is 14, which is almost a pill on a short button. Pick 12 for fields and either 12 or a real pill for buttons, then stop.

---

## 6. Spacing

`Layout.swift` already has the scale:

```text
4
8
12
16
24
32
```

The drift is that screens still invent neighbors (`13` on the lists add control and list-type container, `19`-style one-offs, Discover’s own padding). Use the scale for the relationship that repeats: screen padding 16, space between sections 24, space inside a row 8 or 12.

`LayoutGuide.md` already says not to force every one-off through Layout. Keep that. Standardize the repeated relationships only.

---

## What to do first

Colors, typography, and buttons. Those three files already exist (`Colors.swift`, `Fonts.swift`, `Buttons.swift`). The work is to reduce them, not to invent a new system beside them.

After that, the first screen change worth making is the clothing add row, because it is the loudest mismatch on Profile. Leave the Profile layout and the List layout alone until the three basics are settled.

Login stays the benchmark: few elements, one filled action, text for the rest. Carry that into the app. Do not make login busier.
