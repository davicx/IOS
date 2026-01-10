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
    
    var currentPost: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        //EditItemViewController
        printPageInfo(vcName: "EditItemViewController")

        print(currentPost?.postCaption)
        print(currentPost?.itemName)

    }

}
