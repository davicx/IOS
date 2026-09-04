# Feature: Wishlist Item Purchase (visibility picker)

**Status:** Plan locked — ready to implement (iOS MVP)  
**Scope:** `IOS/Kite/Kite` + existing API (no new API privacy work)  
**Related UI:** `App/Main/Post/Components/Item/ItemInfo.swift` · `ItemPurchaseViewController`  
**Related API:** `api/application/logic/items.js` · `api/application/functions/itemFunctions.js`

Hand this doc to another machine / agent. Decisions below are **locked**. Do not reopen Q1–Q5 unless product changes.

---

## Goal

Gift-list purchase flow: buyer picks **which group members can see** that an item was purchased. Unselected members still see a normal **Purchase** button.

Real-world case: you bought a gift for someone and do not want them (or others) to know yet.

---

## Locked product rules (Q1–Q5)

| # | Decision |
|---|----------|
| Q1 | Picker list = **group members** (not full friend list) |
| Q2 | **Empty selection allowed** (secret to everyone except buyer) |
| Q3 | **MVP = iOS presentation only.** API may still return full `purchased` / `purchased_by` to all clients. Real API redaction is **later**. |
| Q4 | Non-buyer who sees **Purchased**: tap → alert only, e.g. `"{purchasedBy} purchased this item already."` Only **buyer** can cancel. |
| Q5 | **List owner** (`post_from`): hide purchase button, **keep layout** (`isHidden = true`, do not remove constraints / collapse height). |

### Button matrix

| User | Button | Tap |
|------|--------|-----|
| **Buyer** (`purchased_by == currentUser`) | **You Purchased** | Cancel / manage purchase |
| **Selected viewer** (in `purchased_viewers`) | **Purchased** | Message: “{name} purchased this item already.” |
| **Unselected member** | **Purchase** | Open group-member picker → purchase API |
| **List owner** (`post_from`) | **Hidden** | — |

### How iOS decides state (MVP)

Do **not** show **Purchased** merely because `purchased == 1`. Use:

```text
1. currentUser == postFrom     → hidden
2. purchased == 1 && purchasedBy == me → youPurchased
3. purchased == 1 && me in purchasedViewers → purchased(by)
4. else → purchase
```

---

## Architecture boundary

```text
MVP:   presentation / “privacy” UI lives in iOS
Later: API redacts purchased / purchased_by unless viewer is buyer or in purchased_viewers
```

Do **not** expand backend for secrecy in this feature pass.

---

## What already exists (do not rebuild)

### API (ready)

| Endpoint / piece | Notes |
|------------------|--------|
| `POST /items/purchase/add` | Body: `currentUser`, `postID`, `showPurchased: [usernames]` (may be `[]`) |
| `POST /items/purchase/remove` | Clears purchase + visibility rows |
| `item_purchases` table | `visible_to_user_name` per row |
| Item fetch enrichment | `item.purchased_viewers` via `addPurchaseViewersToItems` |
| List-owner strip | API removes `post_from` from `showPurchased` on insert (gift surprise) |

Key files:

- `api/application/routes/itemRoutes.js`
- `api/application/logic/items.js` — `purchaseItem`, `removePurchase`
- `api/application/functions/itemFunctions.js` — `insertGroupPurchase`, `deleteGroupPurchaseVisibility`, `addPurchaseViewersToItems`

### iOS (half-built — wire, don’t reinvent)

| Piece | Path | Status |
|-------|------|--------|
| Purchase / remove API clients | `Kite/API/PostsAPI.swift` | Ready |
| Business calls | `Kite/Functions/Posts/PostLogic.swift` — `purchaseItem` / `removeItem` | Ready |
| Local cache update | `Kite/Functions/Controllers/PostDataController.swift` — `markItemPurchased` / `markItemUnpurchased` | Ready |
| Picker VC (checkmarks) | `Kite/App/Main/Post/PostActions/ItemPurchaseViewController.swift` | Exists; loads **group members**; empty selection OK |
| Current Purchase button | `Kite/App/Main/Post/Components/Item/Components/ItemInfo.swift` | **Stub** — `purchaseTapped` only `print("purchase")` |
| Old present path | `.../DELETE/.../ItemCellLayout.swift` | Legacy; wire from **current** Item cell / post VC instead |

Models: `PurchaseItemModel`, `PurchaseItemResponseModel`, `RemovePurchasedItemModel` under `Kite/API/Models/Posts/Actions/`.

---

## Implementation steps (ordered)

### Step 0 — Optional API smoke (no feature code)

Confirm:

1. Purchase with `showPurchased: ["sam"]` succeeds  
2. Purchase with `showPurchased: []` succeeds  
3. Fetch items includes `purchased`, `purchased_by`, `purchased_viewers`  
4. Remove purchase clears state  

### Step 1 — Button-state helper

Add a small pure helper (new file or on `Post`):

```text
func purchaseButtonState(post: Post, currentUser: String) -> PurchaseButtonState
// .hidden | .purchase | .youPurchased | .purchased(by: String)
```

Implement the decision tree in **Locked product rules** above.

### Step 2 — `ItemInfo` UI

In `ItemInfo.configure` (pass `currentUser` or read from shared controller):

- Apply state → title / enabled / `isHidden`  
- Keep layout when hidden (Q5)  
- Forward tap via callback/delegate to owning cell or VC (prefer not to hardcode navigation inside `ItemInfo`)

### Step 3 — Purchase tap → picker → API

When state is `.purchase`:

1. Present `ItemPurchaseViewController` with `post` + `groupID`  
2. Keep group-member loading (active + pending as today)  
3. Confirm → `PostLogic.shared.purchaseItem(post:groupID:showPurchased:)`  
4. On success → notify UI (`postUpdated` / reload)

Ensure present works from **live** Wishlist `PostCell` / `ItemBody` / `IndividualPostViewController` path — not only DELETE layout.

### Step 4 — You Purchased → cancel

When state is `.youPurchased`:

- Alert / action sheet: **Cancel purchase**  
- Confirm → `PostLogic.shared.removeItem(...)`  
- Refresh UI  

### Step 5 — Purchased (viewer) → info only

When state is `.purchased(by:)`:

- Alert: `"{purchasedBy} purchased this item already."`  
- No API call  

### Step 6 — End-to-end acceptance

- [ ] List owner: button hidden, layout unchanged  
- [ ] A buys, selects only B → A **You Purchased**; B **Purchased**; C **Purchase**  
- [ ] Empty selection → A **You Purchased**; B/C **Purchase**  
- [ ] A cancels → everyone **Purchase**  
- [ ] B taps **Purchased** → message only, no cancel  

---

## Files likely to touch (iOS)

| File | Change |
|------|--------|
| `.../Item/Components/ItemInfo.swift` | Titles, hide, tap routing |
| Cell / `IndividualPostViewController` (owner of ItemInfo) | Present picker + alerts |
| `ItemPurchaseViewController.swift` | Confirm group members + empty OK (likely already OK) |
| New tiny helper or `Post` extension | Button state |
| Maybe notification after purchase | Ensure table reloads |

**API:** none required for MVP (smoke only).

---

## Out of scope

- API redaction of purchase fields (Q3-B / later)  
- Friend-list picker  
- Editing viewer list after purchase without cancel+rebuy  
- Redesign of Item layout / PostSocials  
- Home vs group feed differences beyond the same button rules  

---

## Quick context for the other computer

Workspace roots:

```text
IOS/Kite/Kite/Kite/     ← iOS app source
api/application/        ← Node API
IOS/Doc/                ← this handoff folder
```

App feature docs also live under:

```text
IOS/Kite/Kite/Kite/Docs/
```

This purchase plan is intentionally in **`IOS/Doc`** for cross-machine handoff.

When implementing: follow existing patterns in `PostLogic`, `PostsAPI`, and `ItemPurchaseViewController`. Prefer wiring over new architecture.
