//
//  CustomButtonHandler.swift
//  simpleButton
//
//  Created by David Vasquez on 5/22/25.
//

import Foundation



// MARK: - Protocol
protocol ButtonDelegate: AnyObject {
    func buttonWasTapped()
}

// MARK: - Custom Button Handler
class CustomButtonHandler {
    weak var delegate: ButtonDelegate?

    func simulateTap() {
        print("Button logic was triggered.")
        delegate?.buttonWasTapped()
    }
}
