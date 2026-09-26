//
//  SettingsViewController.swift
//  Instagram
//
//  Created by David Vasquez on 10/17/24.
//

import UIKit
import SafariServices


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
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingCellModel(title: "Invite Friends") { [weak self] in
                self?.didTapInviteFriends()
            },
            SettingCellModel(title: "Save Posts") { [weak self] in
                self?.didTapSavePosts()
            }
        ])
        
        data.append([
            SettingCellModel(title: "Terms of Service") { [weak self] in
                self?.openURL(type: .terms)
            },
            SettingCellModel(title: "Privacy Policy") { [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingCellModel(title: "Help / Feedback") { [weak self] in
                self?.openURL(type: .help)
            }
        ])
        
        
        let section = [
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogout()
                
            }
        ]
        data.append (section)
        
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }

    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present (navVC, animated: true)
    }
    
    
    private func didTapInviteFriends() {
        
    }
    
    private func didTapSavePosts() {
        
    }
    

    
    private func openURL (type: SettingsURLType) {
        let urlString: String
        
        switch type {
            case .terms: urlString = "https://www.youtube.com"
            case .privacy: urlString = "https://www.youtube.com"
            case .help: urlString = "https://www.youtube.com"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present (vc, animated: true)
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
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
}


