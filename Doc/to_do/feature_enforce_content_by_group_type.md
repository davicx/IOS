# Kite — Enforce Content by Group Type

## Goal

Make the split hard at the **API** (DB stays clean even if a client misbehaves):

```text
group_type = wishlist  →  only items   (post_type = item, master_site = wishlist)
group_type = kite      →  only posts   (post_type = photo | text, master_site = kite)
```

iOS should still call the right create screens, but **server rules are the source of truth**.

**Status:** Plan (not started)  
**Depends on:** [feature_group_type_filter.md](./feature_group_type_filter.md) (list/filter groups by type) · Dev DB cleaned (70 kite / 80 + 82 wishlist)

**Related:** `Functions/Docs/Kite.swift` mode checklist (NewPost vs NewItem)

---

## Product rule

| Group `group_type` | Allowed create     | Allowed list fetch              | Forbidden                         |
| ------------------ | ------------------ | ------------------------------- | --------------------------------- |
| `wishlist`         | `POST /post/item`  | `GET /items/group/:id` (items only) | photo / text / video posts     |
| `kite`             | `POST /post/text`, `POST /post/photo` (+ video if used) | `GET /posts/group/:id` (non-items) | item posts                  |

One shared `posts` table is fine. Separation is **group_type + post_type + master_site**, enforced on write and preferred on read.

---

## Why API-first

Today:

- Create item / photo / text only checks auth + payload; **no lookup of the group’s `group_type`**
- `GET /items/group/:id` returns **all** posts in the group (`LEFT JOIN items`) — photos come back with `item: null`
- `GET /posts/group/:id` returns all posts in the group — would include items if any landed there
- iOS can still open `NewPostViewController` on a wishlist group (mode flip incomplete)

Client-only discipline will drift again. Guard writes (and tighten reads) in the API.

---

## Plan

### Phase A — Shared helper: resolve group + type

**Where:** e.g. `Group.js` or a small helper used by post/item create + fetch.

**Do:**

1. Given `groupID`, load: `group_id`, `group_type`, `group_deleted`, membership of current user.
2. Fail if missing / deleted / user not an active member.
3. Return `groupType` (`kite` | `wishlist`) for callers to branch on.

Use this on **every** create and on group-scoped post/item GETs.

---

### Phase B — Enforce on create (core)

**Files (API):**

- `application/functions/classes/Post.js` — `createPostText`, `createPostPhoto`, `createPostItem` (and video if live)
- `application/logic/posts.js` / `application/logic/items.js` — handlers that call those
- Routes: `POST /post/text`, `POST /post/photo`, `POST /post/item` (and local/aws variants that create content)

**Rules:**

| Endpoint / method   | Require group_type | Force on insert                                      | Reject if                          |
| ------------------- | ------------------ | ---------------------------------------------------- | ---------------------------------- |
| `createPostItem`    | `wishlist`         | `post_type = 'item'`, `master_site = 'wishlist'`     | group is `kite` (or unknown)       |
| `createPostText`    | `kite`             | `post_type = 'text'`, `master_site = 'kite'`         | group is `wishlist`                |
| `createPostPhoto`   | `kite`             | `post_type = 'photo'`, `master_site = 'kite'`        | group is `wishlist`                |

**Response:** `403` or `400` with a clear message, e.g. `"Items can only be created in wishlist groups"`.

**Do not trust the client** for `master_site` / `post_type` on these paths — set them server-side from the rule above (client may still send them for logging; server overwrites).

**Also:** `post_to` — if the app uses it as group id string, set `post_to = String(groupID)` on create unless product needs DM-style targets; document the choice. Avoid inventing `post_to` from client when it disagrees with `group_id`.

---

### Phase C — Enforce on fetch (keep feeds clean)

**Files:**

- `Post.js` — `getGroupPostsAll` (or equivalent for `GET /posts/group/:id`)
- `Post.js` — `getGroupItemsAll` (or equivalent for `GET /items/group/:id`)

**Rules:**

```text
GET /posts/group/:groupId
  → group must be group_type = kite (else 404/403)
  → WHERE post_type IN ('photo', 'text'[, 'video'])   -- exclude 'item'

GET /items/group/:groupId
  → group must be group_type = wishlist (else 404/403)
  → WHERE post_type = 'item'                           -- require item row / type
```

This stops kite photos leaking into Wishlist UI when someone opens the wrong id or when old mixed rows exist.

---

### Phase D — Create group already typed (from sibling plan)

From [feature_group_type_filter.md](./feature_group_type_filter.md):

- Create list → `group_type = 'wishlist'`
- Create event → `group_type = 'kite'`
- List endpoint filters by `groupType`

Without correct group typing, Phase B has nothing trustworthy to check.

---

### Phase E — iOS alignment (thin; API already protects DB)

**Do not dual-implement business rules** — just call the right endpoints:

| Mode / group type | Create UI                 | API                         | Fetch                         |
| ----------------- | ------------------------- | --------------------------- | ----------------------------- |
| Wishlist          | `NewItemViewController`   | `POST /post/item`           | `fetchWishlistItems` / items  |
| Kite              | `NewPostViewController`   | `POST /post/photo` or text  | `fetchKitePosts` / posts      |

**Checklist touchpoints** (existing `Kite.swift` flips):

- `IndividualGroupViewController` create button + fetch (today can mix Wishlist fetch + Kite create)
- `HomeViewController` fetch + `getHomeFeedPosts()` same group id (70 kite / 80 wishlist)
- Create-group `groupType` string matches mode

If API returns 403, surface a simple error; do not silently fall back to the other create path.

---

## Suggested order

| Step | Work                                      | Owner |
| ---- | ----------------------------------------- | ----- |
| 1    | Group resolve helper (type + membership)  | API   |
| 2    | Reject wrong creates (Phase B)            | API   |
| 3    | Filter fetches by type (Phase C)          | API   |
| 4    | Groups list `?groupType=` + create typing | API + iOS ([group type filter plan](./feature_group_type_filter.md)) |
| 5    | iOS NewItem vs NewPost + Home id align    | iOS   |

Steps 1–3 alone keep the **database** clean. Steps 4–5 keep the **UI** clean.

---

## Acceptance checks

**Creates**

- [ ] `POST /post/item` into group **80** (wishlist) → success; row is `item` + `wishlist`
- [ ] `POST /post/item` into group **70** (kite) → rejected
- [ ] `POST /post/photo` (or text) into **70** → success; row is photo/text + `kite`
- [ ] `POST /post/photo` into **80** → rejected

**Fetches**

- [ ] `GET /items/group/80` → only the item posts (no photo/text)
- [ ] `GET /posts/group/70` → only photo/text (no items)
- [ ] `GET /items/group/70` → rejected or empty by policy (prefer reject)
- [ ] `GET /posts/group/80` → rejected or empty by policy (prefer reject)

**UI (after iOS wire)**

- [ ] In a wishlist group, add flow only creates items
- [ ] In a kite group, add flow only creates posts
- [ ] Wrong mode create cannot pollute the other app’s group even via crafted API calls

---

## Out of scope

- Separate physical databases or duplicate `posts` tables
- Full dual-mode runtime flag (still comment/uncomment until you add one)
- Migrating production historical mixed rows beyond the already-done dev cleanup

---

## Notes

- Prefer **one helper** used by all create variants (`/post/photo`, `/post/photo/local`, `/post/photo/aws`, etc.) so a path isn’t left unguarded.
- Notifications currently hardcode `masterSite: "kite"` in places — when creating items, notifications should use `wishlist` (fix when touching item create).
- After Phase B–C, re-run a quick SQL sanity check on `posts` grouped by `group_id`, `master_site`, `post_type` to confirm no new mixed rows.
