# App Header System

Yes — and I think the confusion comes from mixing **two separate concepts**:

1. **The header container/layout**
2. **What each screen puts inside that header**

In iOS, the cleanest pattern is usually to have **one shared navigation/header system**, but let each screen configure its contents.

![Image](https://images.openai.com/static-rsc-4/z4hd4cKwf8mLyq_k-A_ngBuUInwwUyOUHheIZLq4MoLPlRQxGzOLkJpMRgXrwjd442h9sUXXJ8y-RVQCyg93ss5k3L4phlxu0BKC-9om3zIUMFhC9coH--AZ0o-7rYwMKBX7c0C0TF4KtNTpHIvKCnMZyp-CFu1_2RN42WFKcM7N0_skPeivPkg0PqrKvQMg?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/2Q6aOASfQxPsfIV6hUe0wFnSbxQj936GAZ7i9cTCQL33ptbeNIOoDuYInUC1mOQny0fgKWhALQLtWaGd1cG0Jt_PunLNW9GlmppzDoWArPTONP6fT3h6hb8dVrJVmLoyL6nEScnOlln7vy5_x0f3LCbqeqYTUHv_bVy4-dvRJHLtry4Gg0UTSr5rMFNFBPtI?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/eo-KvGrAUGt-QZS4rzdUKRCtG_wgaVTg7eBtyCSP-9_p6P7-Nkd9zOZrjzJxLUzSGXT2hDff83b3o3IVe6UsoCM60f01_bgwVH2CYnK-7WOt4aDiBVAZp0G3-2TPqqv3iAiSsTYy0JsIc4tvxX6yPhsRHCyESVpqxBvdgpS6NFRxZ7pAhXczhqgZZGMHj6nJ?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/F2JwdlHnjwmmOo0FtBY6hDeKh8gwtgT7MVhBMKyrBjB62CG7loA8LeFKwcQlhOq7TwxL9-1UgSdXy4svw6R1ztWPvvJ-5oVYIzY9aseni_3NUFYyjHp-uPtVCPX74XJYhjsn-_i6puGVyvuVI_8egw0LssqUu_KxQvEchbQTUMqnp8H3peOy3qKKdtU_zITq?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/C3QiuNfi_Mz9h004eaNubFqYUEoWfbT5Bw18_WvtjN51hAeXlcMKFrCYBcr0FUMCfsHB--FhzLr3ref6A1bhBJnyNCjziC-mg6aoCovKllU03V2c0NoaINJMiyJnm9_bvfaWRZLkSw-jAX5ed-NwGcWNR46yFVx5dpBPultFx5BqI01TI4-m8eQ2KhtkBYjK?purpose=fullsize)

### A good mental model

Think of your app like this:

```text
APP / NAVIGATION
│
├── Shared Header System
│     ├── Left area
│     ├── Center/title area
│     └── Right area
│
└── Current Screen
      └── Content
```

Then each screen tells the header what it needs.

For example:

```text
HOME
[ Profile ]      KITE       [ + ]

SEARCH
[ Back ]        Search      [ Filter ]

GROUP
[ Back ]    Hiking Club     [ ••• ]

POST
[ Back ]        Post
```

You **don't need four completely different header implementations**. You have one reusable component with configurable pieces.

Something conceptually like:

```swift
AppHeader(
    title: "Search",
    leftItem: .back,
    rightItem: .filter
)
```

versus:

```swift
AppHeader(
    logo: "Kite",
    leftItem: .profile,
    rightItem: .add
)
```

That pattern fits especially well with the component approach you've been moving toward.

### Fixed vs scrolling

There's no universal rule that headers should disappear when scrolling. I would start simpler.

**Keep the navigation/header fixed. Let the content scroll underneath it.**

```text
┌───────────────────────────────┐
│ [Profile]    KITE       [+]   │  ← stays
├───────────────────────────────┤
│                               │
│ Feed content                  │  ↑
│                               │  │ scrolls
│ Post                          │  │
│                               │
│ Post                          │  │
│                               │
└───────────────────────────────┘
```

That's predictable, easy to implement, and easy for users to understand.

Collapsing/disappearing headers are useful when the header consumes substantial vertical space. Apple's common large-title behavior is a good example:

```text
Search

[ Search........................ ]

content
content
content
```

As you scroll:

```text
        Search

content
content
content
```

The **large presentation collapses**, but navigation doesn't completely disappear.

### What I'd do in your app

I would establish one rule:

> **Every primary screen uses the same header frame, but the screen controls the header's contents.**

Then define maybe four basic header configurations:

```text
HOME
[avatar]       Logo       [action]

STANDARD PAGE
[back]         Title      [action]

SEARCH
[back]         Search     [filter]

DETAIL
[back]         Title      [...]
```

And importantly, **don't solve disappearing/collapsing headers yet**. Keep yours fixed initially. Once the whole app is assembled, you might discover that a particular screen benefits from collapsing behavior.

That gives you something very similar to the CSS component philosophy we discussed: **one structural component, several semantic configurations**, rather than independently designing a header on every screen.
