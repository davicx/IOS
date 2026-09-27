# Feature: Profile — About Me + Clothing Preferences

**Status:** Step 3 schema locked — run `create_user_preference.sql`, then API CRUD  
**Scope:** `IOS/Kite/Kite` + `api`  
**Mock:** Profile About Me (avatar / stats / About Me | Posts / bio / Clothing & Sizes list)  
**Docs folder:** `IOS/Kite/Kite/Doc/feature_profile.md`  
**SQL:** `api/doc/database/scripts/create_user_preference.sql`

---

## Goal

Own-profile **About Me** tab shows:

1. Biography (already displaying)
2. **Clothing & Sizes** preferences list (Shoes / Coats / Shirts style rows) with add / edit / delete, kept in sync via a DataController like posts/users/groups

Fixed chrome stays put; only content below the switch scrolls (already wired).

```text
ProfileViewController
│
├── Profile Header                 ← FIXED
│   ├── Avatar
│   ├── Name / @username
│   └── Posts / Groups / Friends
│
├── About Me | Posts               ← FIXED (ProfileModuleSlider)
│
└── Content Area                   ← FILLS remaining space; scrolls inside
    ├── About Me (scroll)
    │   ├── AboutMe (biography)
    │   └── ClothingModule (preferences)
    └── Posts (PostList — later)
```

---

## Product naming (lock this)

| UI label (mock) | Code / API / DB name |
|-----------------|----------------------|
| Clothing & Sizes | Preferences (domain) |
| Row title e.g. `Shoes` | `preference_title` |
| Row detail e.g. `Men's 12` | `preference_description` |
| Section type | `preference_category` (MVP: `clothing`) |
| `+ Add clothing note` | Add Preference |

Use **Preference** in API / models / DataController. Keep **Clothing & Sizes** as the section title in UI unless you rename the mock later.

---

## Steps

### 1) Add About Me and Posts — ✅ Done

- `ProfileModuleSlider` — About Me | Posts
- Fixed header + slider; `moduleContainerView` fills to safe area
- `AboutMeModule` scrolls; `PostList` fills same container (placeholder)

**Files:** `ProfileViewController.swift` · `ProfileModuleSlider.swift` · `AboutMeModule.swift` · `PostList.swift`

---

### 2) Add About Me Biography — ✅ Done (display)

- `AboutMe` shows bio card + **Edit** button
- Configured from `User.biography` via `UsersDataController`

**Still thin (optional follow-up, not blocking Preferences):**

- Bio **Edit** currently `print("(edit)")` — wire to existing `EditProfileViewController` (or inline editor)
- Confirm bio update still refreshes About Me via `didUpdateProfile` / `usersUpdated`

**Files:** `AboutMe.swift` · `EditProfileViewController.swift` · `UsersDataController`

---

### 3) Create Table: User Preferences — schema locked

Table: **`user_preference`** (owned by `user_name`, FK to `user_profile.user_name`).

```sql
CREATE TABLE user_preference (
    user_preference_id INT NOT NULL AUTO_INCREMENT,
    user_name VARCHAR(50) NOT NULL,

    preference_category VARCHAR(100) NOT NULL,
    preference_title VARCHAR(150) NULL,
    preference_description VARCHAR(500) NULL,

    display_order INT NOT NULL DEFAULT 0,
    active TINYINT(1) NOT NULL DEFAULT 1,

    updated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (user_preference_id),

    KEY idx_user_preference_user_active (user_name, active, display_order),

    CONSTRAINT fk_user_preference_user_name
        FOREIGN KEY (user_name)
        REFERENCES user_profile(user_name)
        ON DELETE CASCADE
);
```

**Apply (new DB):** `api/doc/database/scripts/create_user_preference.sql`  
**Already created with `user_profile_id`?** Run: `api/doc/database/scripts/alter_user_preference_use_user_name.sql`

**MVP field mapping (Clothing & Sizes UI):**

| DB column | Example | UI |
|-----------|---------|-----|
| `user_name` | `davey` | owner |
| `preference_category` | `clothing` | section / type |
| `preference_title` | `Shoes` | row title |
| `preference_description` | `Men's 12` | row detail / note |
| `display_order` | `0` | list order |
| `active` | `1` / `0` | soft-delete |

**Defer:** `icon_key` / uploaded images (emoji or SF Symbol in iOS for MVP).

Document in iOS `DatabaseSchema.swift` when wiring models.

---

### 4) Add API routes for Preferences

Need **list/fetch** as well as mutate (your list had Add/Edit/Remove only — fetch is required).

| Method | Route (suggested) | Body / params | Purpose |
|--------|-------------------|---------------|---------|
| `GET` | `/preferences/:userName` | — | List active prefs for a profile |
| `POST` | `/preferences/add` | `currentUser`, `preferenceTitle`, `preferenceDescription`, optional `preferenceCategory` | Create |
| `POST` | `/preferences/edit` | `currentUser`, `userPreferenceID`, `preferenceTitle`, `preferenceDescription`, … | Update |
| `POST` | `/preferences/remove` | `currentUser`, `userPreferenceID` | Soft-delete (`active = 0`) |

**Rules:**

- Only owner (`currentUser == preference.user_name`) may add / edit / remove
- Friend / public profile: **GET allowed**, mutations rejected
- Return consistent JSON envelope like other routes (`success`, `message`, `data`, `errors`)

**Suggested files:**

```text
api/application/routes/preferenceRoutes.js   (or profileRoutes)
api/application/logic/preferences.js
api/application/functions/preferenceFunctions.js
```

---

### 5) Add Preference (iOS)

Wire **`+ Add clothing note`** (`ClothingFooterAddNew`) — currently non-interactive.

Flow:

```text
Tap Add
  → present Add/Edit Preference screen (or sheet)
  → title + note (required)
  → Save → API add → PreferencesDataController upsert → notify → list reloads
```

Match mock: dashed blue button under the list.

---

### 6) Click Preference → show / Edit / Delete (iOS)

Wire list rows (`ClothingBodyList`) — currently static temp data.

Flow:

```text
Tap row
  → detail / edit screen (prefilled title + note)
  → Save → API edit → controller update → reload
  → Delete → confirm alert → API remove → controller remove → reload
```

**Also decide (currently unclear in UI):**

| Control | Suggested behavior |
|---------|-------------------|
| Section **Edit** (`ClothingHeader`) | Enter “manage” mode **or** same as tapping first row — **or hide** if row tap + Add are enough |
| Row chevron | Open edit/detail |
| Own profile vs friend | Own: add/edit/delete. Friend: read-only list (no Add, no Edit) |

---

### 7) Data class / DataController (iOS sync)

Mirror `PostDataController` / `UsersDataController` / `GroupDataController`.

```text
PreferencesDataController.shared
  ├── preferencesByUsername: [String: [Preference]]
  ├── fetchPreferences(username:)
  ├── addPreference(...)
  ├── editPreference(...)
  ├── removePreference(...)
  └── NotificationCenter: .preferencesUpdated
```

**Pieces:**

| Piece | Role |
|-------|------|
| `Preference` class/struct | `preferenceID`, `userName`, `title`, `note`, `iconKey`, `sortOrder` |
| `PreferencesAPI` | HTTP only |
| `PreferencesDataController` | Cache + mutate + notify |
| UI | Observe `.preferencesUpdated`, reconfigure `ClothingBodyList` |

Do **not** put API calls inside list cells. UI renders from controller cache only.

**Suggested paths:**

```text
Functions/Classes/Preference.swift
Functions/Controllers/PreferencesDataController.swift
API/PreferencesAPI.swift
API/Models/Preferences/...
```

---

## Current UI map (reuse, don’t rebuild shells)

```text
AboutMeModule (UIScrollView)
├── AboutMe                    ← bio ✅
└── ClothingModule
    ├── ClothingHeader         ← "Clothing & Sizes" + Edit + subtitle
    ├── ClothingBodyList       ← TEMP hardcoded Shoes/Coats/Shirts
    └── ClothingFooterAddNew   ← "+ Add clothing note" (disabled)
```

Replace temp rows with live `Preference` models; enable buttons; keep layout/style.

---

## Recommended build order

```text
3  DB table
4  API: GET + add + edit + remove
7  iOS Preference model + PreferencesAPI + PreferencesDataController
   (fetch + empty list first)
5  Add Preference UI → API → sync
6  Tap row → Edit / Delete UI → API → sync
   then: friend profile read-only, bio Edit polish, Posts tab
```

Doing **7 before 5–6** avoids wiring UI to one-off network calls that fight the sync pattern.

---

## What’s missing from your original 7 steps

Call these out so they don’t surprise you mid-build:

1. **GET / list preferences** — Add/Edit/Remove alone isn’t enough; profile needs fetch on load.
2. **Data model fields** — lock `title` + `note` (+ optional `icon_key` / sort).
3. **Own vs friend profile** — read-only on `FriendProfileViewController` (or shared About Me module with `isOwner`).
4. **Empty state** — no preferences yet (copy + Add still visible for owner).
5. **Section Edit vs row tap vs Add** — three entry points in the mock; pick roles so you don’t build duplicate editors.
6. **Icons** — mock images vs current emoji; MVP = emoji/`icon_key`, custom images later.
7. **Bio Edit wiring** — display done; Edit action not finished.
8. **Posts tab** — out of scope for Preferences, but still a placeholder; don’t block Preferences on it.
9. **Validation** — max lengths matching DB (`title` 80, `note` 255), trim empty saves.
10. **AuthZ** — server must reject edit/delete of someone else’s preference (don’t trust client alone).

---

## Explicit non-goals (this feature)

- Collapsing profile header on scroll
- Preference images upload / cloud storage
- Reorder / drag-and-drop sort (keep `sort_order` simple / append-only for MVP)
- Making Posts tab a full feed (separate feature)
- Changing fixed header + slider architecture

---

## Done when

- [ ] `user_preference` table exists; schema documented (`create_user_preference.sql`)
- [ ] API: list / add / edit / remove working
- [ ] `PreferencesDataController` caches + posts `.preferencesUpdated`
- [ ] About Me list shows live preferences (no temp hardcode)
- [ ] Owner can Add, Edit, Delete with confirm on delete
- [ ] Friend profile can view preferences (read-only)
- [ ] Header + About Me | Posts stay fixed; preferences scroll inside About Me

---

## Notes

- Prefer **Preferences** naming in code even if UI says Clothing & Sizes.
- Match existing controller style: singleton, async fetch, NotificationCenter reload — same as posts/users.
- Keep About Me / Clothing shells; replace data + actions only.
