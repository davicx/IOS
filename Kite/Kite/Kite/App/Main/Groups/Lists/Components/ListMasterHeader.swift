//
//  ListMasterHeader.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//

import UIKit


final class ListMasterHeader: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        ViewStyle.placeholderContent(
            in: self,
            title: "ListMasterHeader",
            backgroundColor: UIColor(red: 1.0, green: 0.85, blue: 0.80, alpha: 1.0),
            height: 100
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
