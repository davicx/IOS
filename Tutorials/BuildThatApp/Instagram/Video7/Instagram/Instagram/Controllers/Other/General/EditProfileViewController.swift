//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by David Vasquez on 10/17/24.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

class EditProfileViewController: UIViewController  {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[EditProfileFormModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        //NAVIGATION: Navigation Bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector (didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        
        //TABLE VIEW: Profile Table View
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
        
        //
        configureModels()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc private func didTapSave() {
        print("save")
    }
    
    @objc private func didTapCancel () {
        print("cancel")
        dismiss(animated: true, completion: nil)
        
    }
    
    func configureModels() {
        //name userName website bio
        let sectionOneLabels = ["Name", "Username", "Bio"]
        var sectionOne = [EditProfileFormModel]()
        
        for label in sectionOneLabels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)..", value: nil)
            sectionOne.append(model)
        }
        models.append(sectionOne)
                                         
        //email phone gender
        let sectionTwoLabels = ["Email", "Phone", "Gender"]
        var sectionTwo = [EditProfileFormModel]()
        
        for label in sectionTwoLabels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)..", value: nil)
            sectionTwo.append(model)
        }
        models.append(sectionTwo)
                         
        
    }
    
 
    
    @objc private func didTapChangeProfilePicture () {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction (title: "Take Photo", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction (title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction (UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //So IPad works
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true)
        
    }
    
    //TABLE VIEW
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        let size = header.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width-size)/2, y: (header.height-size)/2, width: size, height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.tintColor = .label
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.addTarget(self,
                                     action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        return header
    }
    
    @objc private func didTapProfilePhotoButton () {
    }
    

}




extension EditProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        let model = models[indexPath.section][indexPath.row]
        //cell.textLabel?.text = model.label
        cell.configure(with: model)
        cell.delegate = self
        //cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Info"
    }
    /*
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Info"
    }
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
    }

}


extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField value: String?) {
        print("Field updated to: \(value ?? "nil")")
    }
    

}
