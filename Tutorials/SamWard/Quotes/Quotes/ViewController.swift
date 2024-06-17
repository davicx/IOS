//
//  ViewController.swift
//  Quotes
//
//  Created by David on 4/12/23.
//

import UIKit

//STOP 11:00

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    let networker = Networker()
    let groupAPI = GroupAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        networker.getImage { (data, error)  in
          if let error = error {
            print(error)
            return
          }
          
          self.imageView.image = UIImage(data: data!)
        }
        
         */
    }

    @IBAction func randomButton(_ sender: UIButton) {
        //simpleThree()
        
        networker.getQuote {(kanye, error) -> (Void) in
            if let error = error {
                self.label.text = "there was an error!"
            }
            
            self.label.text = kanye?.quote
        }
        
        networker.getImage { (data, error)  in
          if let error = error {
            print(error)
            return
          }
          
          self.imageView.image = UIImage(data: data!)
        }
    }
    
    @IBAction func newGroupButton(_ sender: UIButton) {
        print("New Group")
        
        groupAPI.newGroup {(newGroup, error) -> (Void) in
            if let error = error {
                print(error)
            }
            print("newGroup")
            print(newGroup?.newGroupOutcome)
        }
    }
    
    //SIMPLE 1:
    func simpleOne() {
        let url = URL(string: "https://api.kanye.rest/")!
         
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error)
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: String]
            
            print(json)
            
            DispatchQueue.main.async {
                self.label.text = json["quote"]
            }
        
       }
        task.resume()
    }
    
    //SIMPLE 2:
    func simpleTwo() {
        let url = URL(string: "https://api.kanye.rest/")!
         
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
              print("not right")
              return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
              print("Not right")
              return
            }
            
            guard let data = data else {
              print("bad data")
              return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: String]
                print(json)
                
                DispatchQueue.main.async {
                    self.label.text = json["quote"]
                }
            } catch let error {
                print(error)
            }

       }
        task.resume()
    }

    //SIMPLE 3: Use Codable
    func simpleThree() {
        let url = URL(string: "https://api.kanye.rest/")!
         
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
              print("not right")
              return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
              print("Not right")
              return
            }
            
            guard let data = data else {
              print("bad data")
              return
            }
            
            do {
                let kanye = try JSONDecoder().decode(Kanye.self, from: data)
                print(kanye)
                
                DispatchQueue.main.async {
                    self.label.text = kanye.quote
                }
            } catch let error {
                print(error)
            }

       }
        task.resume()
    }


}






//SIMPLE 3:
func simpleThree() {
}
