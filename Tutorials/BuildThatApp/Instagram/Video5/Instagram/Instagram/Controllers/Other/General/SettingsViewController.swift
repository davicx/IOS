//
//  SettingsViewController.swift
//  Instagram
//
//  Created by David Vasquez on 10/17/24.
//

import UIKit

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}



final class SettingsViewController: UIViewController {
    
    let loginAPI = LoginAPI()
    
    private var data = [[SettingCellModel]]()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        configureModels()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureModels() {
        let section = [
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogout()
                
            }
        ]
        data.append (section)
    }
    
    private func didTapLogout() {
        let logoutOutcome = loginAPI.logoutUser(username: "frodo")
        print(logoutOutcome)
        
        
        let actionSheet = UIAlertController (title: "Log Out",
                                             message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            //Run on main thread
            DispatchQueue.main.async {
                
                //Success
                if(logoutOutcome) {
                    let loginVC = LoginViewController ()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true) {
                        self.navigationController?.popToRootViewController(animated: false)
                        self.tabBarController?.selectedIndex = 0
                    }
                    
                    
                //Could not log out
                } else {
                    print("could not log out user")
                    fatalError("could not log out user")
                }
            }
            
        }))

        actionSheet.popoverPresentationController?.sourceView=tableView
        actionSheet.popoverPresentationController?.sourceRect=tableView.bounds
        
        present(actionSheet, animated: true)

    }

    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
}


