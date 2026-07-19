//
//  EventMembers.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//

import UIKit


final class EventMembers: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        ViewStyle.placeholderContent(
            in: self,
            title: "EventMembers",
            backgroundColor: UIColor(red: 0.78, green: 0.94, blue: 0.88, alpha: 1.0),
            height: 100
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
