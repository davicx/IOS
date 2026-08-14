//
//  Kite.swift
//  Kite
//
//  Created by David Vasquez on 7/20/26.
//
//  MODE SWITCH: Kite vs Wishlist
//  Say: "I'm working on Kite — switch" or "I'm working on Wishlist — switch"
//  Only comment / uncomment the checklist below. Do not refactor.
//

import Foundation

/*

 ========================
 APP MODE SWITCH CHECKLIST
 ========================

 Two apps, one codebase. Shared components stay shared.
 Mode flip = comment/uncomment labeled //KITE and //WISHLIST blocks.

 //Kite
 use PostCell

 //Wishlist
 //use ItemCell


 STATUS KEY
 - DONE        = switch blocks in place and active mode is correct
 - PARTIAL     = some pieces done, still mixed or Wishlist path incomplete
 - NOT STARTED = flip not wired yet


 --------------------------------
 FILES TO SWITCH
 --------------------------------

 1) GroupsViewController
    Path: App/Main/GroupsViewController.swift
    Status: DONE (Kite active)

    Kite:
    - Title: "Your Events"
    - Register / dequeue: EventCell
    - Header: EventsMasterHeader

    Wishlist:
    - Title: "Wishlist"
    - Register / dequeue: GroupCell
    - Header: ListMasterHeader

    Look for: //KITE and //WISHLIST near setupTableView + cellForRow


 2) HomeViewController
    Path: App/Main/HomeViewController.swift
    Status: PARTIAL
    - DONE: Kite PostCell + fetchKitePosts active
    - NOT STARTED: Wishlist ItemCell wire (still comments HomePostCell, not ItemCell)

    Kite:
    - Register / dequeue: PostCell
    - Fetch: fetchKitePosts(groupID:)

    Wishlist:
    - Register / dequeue: ItemCell  (when wired; not HomePostCell)
    - Fetch: fetchWishlistItems(groupID:)


 3) IndividualGroupViewController
    Path: App/Main/Groups/SORT/IndividualGroup/IndividualGroupViewController.swift
    Status: PARTIAL
    - DONE: PostCell + NewPostViewController (Kite create)
    - NOT STARTED: Kite fetch/title (still Wishlist title + fetchGroupWishlistItems)
    - NOT STARTED: Wishlist ItemCell + NewItemViewController flip

    Kite:
    - Register / dequeue: PostCell
    - Fetch: GroupLogic.fetchGroupKitePosts / fetchKitePosts
    - Create button: NewPostViewController
    - Title: Events-style (not "Wishlist")

    Wishlist:
    - Register / dequeue: ItemCell
    - Fetch: fetchGroupWishlistItems / fetchWishlistItems
    - Create button: NewItemViewController
    - Title: "Wishlist"


 4) IndividualPostViewController
    Path: App/Main/Post/IndividualPostViewController.swift
    Status: PARTIAL
    - DONE: PostCell registered (Kite)
    - NOT STARTED: ItemCell Wishlist flip (no //KITE //WISHLIST blocks yet)

    Kite:
    - Register / dequeue: PostCell

    Wishlist:
    - Register / dequeue: ItemCell


 5) PostCell / ItemCell (cell body)
    Paths:
    - App/Main/Post/Cells/PostCell.swift
    - App/Main/Post/Cells/ItemCell.swift
    Status: PARTIAL
    - DONE: PostCell uses PostContent (Kite) with ItemContent commented
    - NOT STARTED: ItemCell still uses PostContent; needs ItemContent + VC wiring

    Kite PostCell:
    - PostContent()

    Wishlist ItemCell:
    - ItemContent()

    Shared forever in both cells:
    - PostCaption
    - PostSocials
    - MainDivider (as used)


 --------------------------------
 STATUS SUMMARY (as of last update)
 --------------------------------

 1) GroupsViewController ............... DONE
 2) HomeViewController ................. PARTIAL
 3) IndividualGroupViewController ...... PARTIAL
 4) IndividualPostViewController ....... PARTIAL
 5) PostCell / ItemCell ................ PARTIAL


 --------------------------------
 HOW TO ASK CURSOR
 --------------------------------

 "Working on Kite — switch"
 → Uncomment //KITE lines, comment //WISHLIST lines in files 1–5.

 "Working on Wishlist — switch"
 → Uncomment //WISHLIST lines, comment //KITE lines in files 1–5.

 Only touch those flips. Leave archived /* */ blocks alone.
 Update statuses in this file when a flip becomes DONE.


 --------------------------------
 DO NOT DUAL-MODE (shared forever)
 --------------------------------

 - PostCaption, PostSocials, CommentCell, MakeComment
 - PostDataController / GroupDataController / APIs
 - Style: Fonts, Colors, Buttons, Dividers
 - Tab bar / storyboard IDs
 - Large SORT / POSTSORT archive folders


 --------------------------------
 NOTES
 --------------------------------

 - ItemCell should use ItemContent (finish before Wishlist cell flip is clean).
 - Prefer NewItemViewController for Wishlist create (not the //WISHLIST block inside NewPostViewController).
 - Groups list: Events (Kite) vs Lists (Wishlist).
 - Groups fetch does NOT filter by group_type yet — see plan below.


 --------------------------------
 RELATED PLANS
 --------------------------------

 - Docs/feature_group_type_filter.md
   Filter groups by group_type (kite | wishlist) — API + iOS.
   Dev DB canonical: 70 kite, 80 Davey wishlist, 82 Sam wishlist.
   Also covers Home fetch/read group ID alignment (80 vs 70).

 - Docs/feature_enforce_content_by_group_type.md
   API-first: wishlist groups only create/fetch items;
   kite groups only create/fetch posts (photo/text).
   Keeps DB clean even if a client calls the wrong endpoint.

 */
