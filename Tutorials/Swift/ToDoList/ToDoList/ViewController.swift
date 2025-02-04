//
//  ViewController.swift
//  ToDoList
//
//  Created by David Vasquez on 7/27/24.
//

import UIKit

class ViewController: UIViewController {

    //let todos = ["Walk the dog", "Wash the car", "Buy milk", "Call a friend", "Cut the grass"]
    var todos = [Todo(title: "Walk the dog", isMarked: false),
                Todo(title: "Wash the car", isMarked: false),
                Todo (title: "Buy milk", isMarked: false),
                Todo (title: "Call a friend", isMarked: true), Todo (title: "Cut the grass", isMarked: false)]
                
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todoTableView.delegate = self
        todoTableView.dataSource = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! ToDoCell
        let todo = todos [indexPath.row]
        cell.taskLabel.text = todo.title
        cell.checkMarkImageView.image = todo.isMarked == true ? UIImage(named: "marked") : UIImage(named: "unmarked")

        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? ToDoCell else { return }
        var todo = todos [indexPath.row]
        todo.isMarked = !todo.isMarked
        todos.remove(at: indexPath.row)
        todos.insert(todo, at: indexPath.row)
        
        
        cell.checkMarkImageView.image = todo.isMarked == true ? UIImage (named: "marked") : UIImage (named: "unmarked")
    }

    
    
}


/*
 //tableView.deselectRow(at: indexPath, animated: true)
 //guard let cell = tableView.cellForRow(at: indexPath) as? ToDoCell else { return }
 //cell.checkMarkImageView.image = UIImage(named: "marked!")
 */
