# Feature: Home Posts Feed

## Goal

Make Home load a real feed from **global** post/item APIs (no hardcoded group `70` / `80`), with two clear entry points:

```text
getHomePosts()
    → getAllPosts
    → ALL Kite posts (no group ID)

getHomePostsWishlist()
    → getAllItems
    → ALL Wishlist item posts (no group ID)
```

**For now (Wishlist-first):** only call `getHomePostsWishlist()` from Home’s initial fetch / refresh / polling.

**Status:** Plan (not started)  
**Related:** [feature_group_type_filter.md](./feature_group_type_filter.md) · [feature_enforce_content_by_group_type.md](./feature_enforce_content_by_group_type.md) · [Kite.swift mode checklist](../Functions/Docs/Kite.swift)

---

## Product rule

| Home function              | Content                         | Global API        |
| -------------------------- | ------------------------------- | ----------------- |
| `getHomePosts()`           | Normal Kite posts (photo/text)  | `getAllPosts`     |
| `getHomePostsWishlist()`   | Wishlist items (`post_type = item`) | `getAllItems` |

Do **not** combine posts and items into one generic fetch. Do **not** filter by group `70` or `80` for this feature.

Later optimization (out of scope for first pass):

```text
getAllItems(limit: 10)
getAllPosts(limit: 10)
```

---

## Inspection result (what already exists)

### Backend

| Wanted | Exists? | Route / handler |
| ------ | ------- | --------------- |
| All posts, no group | **Yes** | `GET /posts` → `posts.getAllPosts` → `PostFunctions.getAllPosts()` (`SELECT * FROM posts ORDER BY post_id DESC`) |
| All items, no group | **No** | Only `GET /items/group/:group_id` → `items.getAllGroupItems` |

Notes on `GET /posts`:

- True global fetch (no group ID).
- Today returns **every** row in `posts` — not filtered to kite-only (`photo` / `text`). Items in that table would come back unless read-side filtering is added later (see enforce-content feature).

### iOS client

| Wanted | Exists? | Where |
| ------ | ------- | ----- |
| Client for `GET /posts` | **No** | `PostsAPI` only has `getPostsAPI(groupID:)` → `/posts/group/:id` |
| Client for `GET /items` (global) | **No** | `PostsAPI` only has `getItemsAPI(groupID:)` → `/items/group/:id` |

False friends (do **not** treat as global):

- `Networker.getPostsAPI()` — no group param, but hardcodes `/posts/group/72`
- `PostDataController.allPosts` — flattens **local cache** only; not a network call

### Home today

`HomeViewController.fetchPosts()` → `fetchWishlistItems(groupID: 80)`  
Table reads `getHomeFeedPosts()` → `getPostsForGroup(groupID: 80)`

That is group-scoped wishlist, not global. Empty home is often posts-vs-items (wrong endpoint), not only a 70/80 mismatch.

---

## Target flow (Wishlist-first)

```text
HomeViewController
        │
        └── getHomePostsWishlist()
                    │
                    ▼
                getAllItems   ← must exist (API + iOS)
                    │
                    ▼
            ALL wishlist items
                    │
                    ▼
            PostDataController store + notify
                    │
                    ▼
            table reload (existing cells — no UI change)
```

Kite path (wired but unused until mode flip):

```text
getHomePosts() → getAllPosts → ALL Kite posts
```

---

## Scope

### Do

1. Add backend **`getAllItems`** + route (global items; no group ID).
2. Add iOS **`PostsAPI`** methods for `GET /posts` and `GET /items` (global).
3. Add / wire `PostDataController` fetch helpers that call those globals (merge into store, post notifications).
4. In `HomeViewController`, add `getHomePosts()` and `getHomePostsWishlist()`; call **only** wishlist for now from initial fetch + polling.
5. Keep posts vs items as **separate** paths end to end.

### Do not (this feature)

- Add `limit=10` / pagination yet.
- Hardcode or filter by group `70` / `80` for Home.
- Invent a new posts endpoint before using existing `GET /posts`.
- Change cells / Home UI (`PostCell` vs `ItemCell` stays a separate mode-flip task).
- Merge posts + items into one fetch.
- Drive-by refactors outside Home + the thin API/controller plumbing above.

---

## Plan

### Phase 1 — API: `getAllItems`

**Blocked without this:** Home wishlist cannot use a real global path.

**Files (API):**

- `application/routes/itemRoutes.js` — add e.g. `GET /items`
- `application/logic/items.js` — `getAllItems` handler (mirror `getAllPosts` shape where practical)
- Item query helper (same pattern as group items / posts) — filter to wishlist items only (`post_type = 'item'`, ideally `master_site = 'wishlist'`)

**Do:**

1. `GET /items` returns all item posts (with item payload), no group ID.
2. Do not return normal kite photo/text posts on this route.
3. Keep `GET /items/group/:group_id` unchanged for list screens.

**Acceptance:**

- [ ] `GET /items` returns items from multiple groups (e.g. 80 and 82) when present
- [ ] Response shape is consumable by existing iOS `PostResponseModel` / item decode path (or document any required client tweak)

---

### Phase 2 — iOS: global API clients

**Files:**

- `API/PostsAPI.swift` — add thin wrappers, e.g. `getAllPostsAPI()` → `GET /posts`, `getAllItemsAPI()` → `GET /items`
- Do **not** reuse `Networker.getPostsAPI()` (hardcoded group 72)

**Do:**

1. Mirror existing group fetch error/decode patterns.
2. Keep group endpoints as-is for Individual Group screens.

**Acceptance:**

- [ ] iOS can call both globals independently
- [ ] No group ID in the URL for either

---

### Phase 3 — PostDataController + Home wiring

**Files:**

- `Functions/Controllers/PostDataController.swift` — fetch-all helpers that call Phase 2 APIs, merge into `groupPosts` (or a dedicated home store if needed), notify `.postsFetched` / `.itemsFetched`
- `App/Main/HomeViewController.swift` — replace single `fetchPosts()` with:

```text
getHomePosts()           → controller getAllPosts path
getHomePostsWishlist()   → controller getAllItems path
```

**Do:**

1. Initial load + `PollingManager` callback call **`getHomePostsWishlist()` only**.
2. Leave `getHomePosts()` implemented but unused (mode flip later = one-line call change).
3. Table can keep reading via existing getters once the store is filled by the global fetch — adjust read path only as needed so Home shows the merged “all items” set (not only group 80).

**Acceptance:**

- [ ] Home shows wishlist items from more than one group when DB has them
- [ ] Home does not call `/posts/group/80` or `/items/group/80` for this path
- [ ] Kite `getHomePosts()` ready but not invoked in Wishlist-first setup

---

### Phase 4 — Later (optional)

- `?limit=10` (or client prefix) on both globals once volume matters
- Align `GET /posts` read filter with [feature_enforce_content_by_group_type.md](./feature_enforce_content_by_group_type.md) (exclude items from all-posts)
- Mode checklist: switch Home call between `getHomePosts` / `getHomePostsWishlist` + cell type (`PostCell` / `ItemCell`)

---

## Suggested order

| Step | Work | Depends on |
| ---- | ---- | ---------- |
| 1 | API `GET /items` + `getAllItems` | — |
| 2 | iOS `getAllPostsAPI` + `getAllItemsAPI` | Step 1 for items; posts can land anytime (`GET /posts` exists) |
| 3 | PostDataController global fetch helpers | Step 2 |
| 4 | Home: `getHomePosts` / `getHomePostsWishlist`; call wishlist only | Step 3 |
| 5 | Limit / pagination | After feed works |

---

## Out of scope

- New Item / Review / create flows ([feature_new_item.md](./feature_new_item.md))
- Groups list `groupType` filter ([feature_group_type_filter.md](./feature_group_type_filter.md))
- Write-side enforce create by group type ([feature_enforce_content_by_group_type.md](./feature_enforce_content_by_group_type.md))
- Home cell redesign / ItemCell flip on Home (mode checklist only)

---

## Acceptance checks (end state)

- [ ] `getAllPosts` reused via iOS for `getHomePosts()` (backend already exists)
- [ ] `getAllItems` exists on API + iOS for `getHomePostsWishlist()`
- [ ] Home Wishlist-first path calls only `getHomePostsWishlist()`
- [ ] No group `70` / `80` hardcoded on that Home fetch path
- [ ] No `limit=10` until a follow-up
- [ ] Posts and items remain separate fetches
