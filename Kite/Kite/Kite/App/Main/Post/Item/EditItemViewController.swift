//
//  EditItemViewController.swift
//  Kite
//
//  Created by David Vasquez on 11/23/25.
//

import UIKit

//FIlE: EditItemViewController
//STORYBOARD ID: EditItemVCStoryboardID
class EditItemViewController: UIViewController {
    
    var currentItem: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentItem?.postCaption)
        print(currentItem?.itemName)

    }

}
