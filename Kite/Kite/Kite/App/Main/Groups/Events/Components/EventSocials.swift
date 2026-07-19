//
//  EventSocials.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//

import UIKit


final class EventSocials: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        ViewStyle.placeholderContent(
            in: self,
            title: "EventSocials",
            backgroundColor: UIColor(red: 0.78, green: 0.88, blue: 0.98, alpha: 1.0),
            height: 80
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
