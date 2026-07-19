//
//  ListSocials.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//

import UIKit


final class ListSocials: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        ViewStyle.placeholderContent(
            in: self,
            title: "ListSocials",
            backgroundColor: UIColor(red: 0.82, green: 0.90, blue: 0.82, alpha: 1.0),
            height: 80
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
