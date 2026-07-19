//
//  EventsMasterHeader.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//

import UIKit


final class EventsMasterHeader: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        ViewStyle.placeholderContent(
            in: self,
            title: "EventsMasterHeader",
            backgroundColor: UIColor(red: 1.0, green: 0.82, blue: 0.86, alpha: 1.0),
            height: 100
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
