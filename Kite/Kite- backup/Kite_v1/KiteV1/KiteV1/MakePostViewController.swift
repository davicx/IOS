//
//  MakePostViewController.swift
//  KiteV1
//
//  Created by Syngenta on 9/10/21.
//

import UIKit

class MakePostViewController: UIViewController {

    @IBOutlet weak var postCaptionText: UITextView!
    
    @IBAction func makePostButton(_ sender: Any) {
        let postCaption = postCaptionText.text
        let postFrom = "davey"
        let postTo = "sam"
        makeTextPost(postFrom: postFrom, postTo: postTo, postCaption: postCaption!)
        print(postCaption!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
}
