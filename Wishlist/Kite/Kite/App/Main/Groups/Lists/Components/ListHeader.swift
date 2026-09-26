//
//  ListHeader.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//

import UIKit


final class ListHeader: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        ViewStyle.placeholderContent(
            in: self,
            title: "ListHeader",
            backgroundColor: UIColor(red: 1.0, green: 0.95, blue: 0.78, alpha: 1.0),
            height: 80
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
