//
//  StyleGuide.swift
//  Kite
//
//  Created by David Vasquez on 2/25/26.
//

import Foundation

/*
 Style
 ├── Elements
 │   └── AppElements.swift
 │
 ├── Text and Fonts
 │   └── AppText.swift
 │
 ├── Style
 │   └── AppStyle.swift
 │
 └── Buttons
 │   └── AppButtons.swift
 │
 ├── Colors
 │   └── AppColors.swift
 
 
 Elements
 Buttons
 Text
 Colors
 Fonts
 
 Style
 ├── Colors
 │   ├── AppColors.swift (more generic like appGray)
 │   └── SemanticColors.swift (Specific FriendBorderRed)
 │
 ├── Fonts
 │   └── AppFonts.swift
 │
 ├── Style
 │   └── AppStyle.swift (Had this before but most stuff seems to be getting put in other files)
 │
 └── Components
     ├── AppButtons.swift
     ├── AppElements.swift (buttons, labels, dividers)
 
 
 */

/*
 Things to watch
 Font vs color coupling
 In Style.swift you have pairs like timeFont + timeFontColor, usernameFont + usernameFontColor. Decide whether those live in AppFonts (and you reference semantic colors from SemanticColors) or in a small AppStyle (or a “text styles” file). Either way, keep the rule consistent so you don’t split the same concept across too many places.
 StyleConstants
 You have things like postHeader, postSocials, postDivider (layout/sizing constants). They could live under Style (e.g. AppStyle.swift or LayoutConstants.swift) or in a Layout/Spacing file. Your plan doesn’t mention constants; adding one line for “layout/spacing constants” would make the structure clear.
 Naming
 “App” prefix is clear. Just keep it consistent (e.g. all in that folder use App* or all use a different convention) so the boundary between app design system and feature-specific style stays obvious.
 Hex initializer
 UIColor(hex:) in your current Colors file is a utility, not a color token. It could stay in AppColors at the bottom, or move to a small UIColor+Hex extension file if you want Colors to be only tokens.
 */
