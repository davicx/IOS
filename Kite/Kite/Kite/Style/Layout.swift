//
//  Layout.swift
//  Kite
//
//  Created by David Vasquez on 8/11/26.
//

import UIKit


enum Layout {

    // MARK: - Spacing

    static let spacingXS: CGFloat = 4
    static let spacingS: CGFloat = 8
    static let spacingM: CGFloat = 12
    static let spacingL: CGFloat = 16
    static let spacingXL: CGFloat = 24
    static let spacingXXL: CGFloat = 32

    // MARK: - Common Sizes

    static let iconSize: CGFloat = 24
    static let touchTargetSize: CGFloat = 40
}


/*
 Layout is for consistency — not for eliminating every number.

 Use Layout when the same kind of UI relationship should feel the same
 across the app (e.g. text→text gaps, outer padding, icon size).

 Do NOT invent one-off values for the same relationship:
   BAD:  8pt between name and price in one place, 5pt in another
   GOOD: both use Layout.spacingXS (or whatever token you chose)

 It is fine to hardcode component-specific geometry that only describes
 that component (card height, image column %, unique one-off sizes).

 Do not force every constant through Layout. Only standardize what is
 reused so the app stays visually consistent.
 */
