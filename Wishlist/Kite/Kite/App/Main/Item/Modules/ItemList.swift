//
//  ItemList.swift
//  Kite
//
//  Profile Content tab. A table of one user's items.
//  Not implemented yet.
//

import UIKit

/*
 ItemList

 Shows that profile's items in the Content tab (your profile and a friend's profile).
 A UIView with a UITableView, same role as ListModule. The profile keeps the header,
 counts, and About Me. ItemList only fills the content area.

 Table
 - UITableView pinned to all edges
 - background Colors.feedBackground
 - separatorStyle .none
 - rowHeight automaticDimension
 - estimatedRowHeight 700
 - empty label "No items yet" when the array is empty

 Cell — copy HomeViewController's row, do not build a new cell
 - register ItemCell, reuse id "ItemCell"
 - cell.usesFeedCard = true
 - cell.configure(with: post)
 - ItemCell already lays out ItemHeader, ItemInfo, ItemFooter, and ItemBody
 - ItemCell already handles purchase, cancel purchase, and "someone else bought this"

 Tap
 - deselect the row
 - onItemSelected?(post) so the profile opens IndividualPostViewController
 - same handoff as Home: postID, and currentUserOwnsGroup from the list's createdBy
   compared with the logged-in user

 Data the profile passes in
 - configure(posts: [Post])
 - posts are already that user's items, with images loaded
 - image loading stays with the caller, the same steps PostDataController uses:
   createPostsArray, addPostImageToPostsArray, addGroupImageToPostsArray,
   addPostFromImageToPostsArray
 - ItemList does not call fetchAllWishlistItems or GET /items
   That call is the home feed: every user's items, newest 12 only

 Still needed before this can show a real list
 - a fetch for one user's items (post_from = that profile)
 - the profile calls configure(posts:) with that result
 - after a purchase change, reload the row (home reloads on .itemsFetched)
 */


