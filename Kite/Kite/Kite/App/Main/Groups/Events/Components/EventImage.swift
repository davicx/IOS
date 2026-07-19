//
//  EventImage.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//

import UIKit


final class EventImage: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        ViewStyle.placeholderContent(
            in: self,
            title: "EventImage",
            backgroundColor: UIColor(red: 0.85, green: 0.82, blue: 0.96, alpha: 1.0),
            height: 220
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
