//
//  DesignStyleTemp.swift
//  Kite
//
//  Temporary style for the Instagram-style design post.
//  Does not replace Colors, Fonts, or Layout.
//

import UIKit


enum DesignStyleTemp {

    //COLORS
    static let background = UIColor.white
    static let primaryText = UIColor.black
    static let secondaryText = UIColor(red: 0.47, green: 0.47, blue: 0.47, alpha: 1)
    static let divider = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
    static let activePage = UIColor(red: 0.0, green: 0.62, blue: 0.95, alpha: 1)
    static let inactivePage = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
    static let liked = UIColor(red: 1.0, green: 0.19, blue: 0.25, alpha: 1)
    static let pageCounterBackground = UIColor.black.withAlphaComponent(0.55)

    //FONTS
    static let usernameFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
    static let likeCountFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
    static let captionFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    static let moreFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    static let dateFont = UIFont.systemFont(ofSize: 13, weight: .regular)
    static let pageCounterFont = UIFont.systemFont(ofSize: 13, weight: .medium)
    static let audioFont = UIFont.systemFont(ofSize: 13, weight: .regular)

    //LAYOUT
    static let headerHeight: CGFloat = 68
    static let headerLeading: CGFloat = 12
    static let headerTrailing: CGFloat = 8
    static let avatarSize: CGFloat = 42
    static let avatarToUsername: CGFloat = 8
    static let touchTarget: CGFloat = 44
    static let mediaAspect: CGFloat = 1.5
    static let actionsHeight: CGFloat = 48
    static let iconPointSize: CGFloat = 26
    static let actionLeading: CGFloat = 8
    static let actionGap: CGFloat = 2
    static let textInset: CGFloat = 16
    static let likesTop: CGFloat = 2
    static let captionTop: CGFloat = 2
    static let dateTop: CGFloat = 6
    static let postBottom: CGFloat = 28
    static let pageCounterTop: CGFloat = 14
    static let pageCounterTrailing: CGFloat = 14
    static let pageCounterHeight: CGFloat = 28
    static let pageCounterPadding: CGFloat = 10
    static let dotSize: CGFloat = 6
    static let dotSpacing: CGFloat = 5
    static let captionLineSpacing: CGFloat = 2
    static let maxCaptionLines = 3
    static let maxDots = 5

    static func outlineIcon(_ name: String) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(pointSize: iconPointSize, weight: .regular)
        return UIImage(systemName: name, withConfiguration: configuration)
    }
}
