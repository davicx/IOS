//
//  CreateGroupViewController.swift
//  Kite
//
//  Created by David Vasquez on 7/3/25.
//


import UIKit


class CreateGroupViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var friends: [User] = []
    private var selectedUsernames: Set<String> = []
    private var selectedGroupImage: UIImage?

    private let headerView = UIView()
    private let closeButton = UIButton(type: .system)
    private let headerTitleLabel = UILabel()

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let nameCaptionLabel = UILabel()
    private let nameField = UITextField()

    private let groupImageView = UIImageView()
    private let selectImageButton = UIButton(type: .system)

    private let inviteCaptionLabel = UILabel()
    private let tableView = UITableView()
    private let createButton = UIButton(type: .system)

    private let fieldCornerRadius: CGFloat = 12
    private let sideInset = Layout.spacingXXL

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground
        setupHeader()
        setupLayout()
        nameField.delegate = self
        nameField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        selectImageButton.addTarget(self, action: #selector(selectGroupImageTapped), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(createGroup), for: .touchUpInside)
        updateCreateButton()
        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "CreateGroupViewController")

        let localFriends = UsersDataController.shared.splitFriendsByStatus().friends
        if localFriends.isEmpty {
            Task {
                do {
                    _ = try await UsersDataController.shared.fetchFriends()
                    self.friends = UsersDataController.shared.splitFriendsByStatus().friends
                    await MainActor.run {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Failed to fetch friends: \(error)")
                }
            }
        } else {
            self.friends = localFriends
            self.tableView.reloadData()
        }
    }

    @objc private func createGroup() {
        guard let groupName = nameField.text, !groupName.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }

        Task {
            do {
                let currentUser = UserDefaultManager().getLoggedInUser()
                let groupType = "wishlist"
                let groupPrivate = 1
                let groupUsers = Array(selectedUsernames) + [currentUser]
                let notificationMessage = "Invited you to a new list"
                let notificationType = "group_invite"
                let notificationLink = "http://localhost:3003/group/77"

                let response = try await GroupsAPI().newGroupFormData(
                    currentUser: currentUser,
                    groupName: groupName,
                    groupImage: selectedGroupImage,
                    groupType: groupType,
                    groupPrivate: groupPrivate,
                    groupUsers: groupUsers,
                    notificationMessage: notificationMessage,
                    notificationType: notificationType,
                    notificationLink: notificationLink
                )

                if response.success == true {
                    GroupDataController.shared.addGroup(response.data)
                    GroupDataController.shared.refreshGroups {
                        print("Groups refreshed after creation")
                    }
                }

                dismiss(animated: true)
            } catch {
                print("Failed to create list: \(error)")
            }
        }
    }

    @objc private func closeTapped() {
        let alert = UIAlertController(title: "Stop creating this list?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Keep editing", style: .cancel))
        alert.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
            self.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    @objc private func selectGroupImageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            groupImageView.image = selectedImage
            selectedGroupImage = selectedImage
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    @objc private func nameChanged() {
        updateCreateButton()
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateCreateButton()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    private func updateCreateButton() {
        let hasText = !(nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        createButton.isEnabled = hasText
        createButton.backgroundColor = hasText ? Colors.buttonPinkBackground : Colors.buttonGrayBackground
        createButton.setTitleColor(hasText ? .white : Colors.subtleGrayText, for: .normal)
    }

    private func setupHeader() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = Colors.newItemInfoBackground
        closeButton.tintColor = Colors.primaryPink
        closeButton.layer.cornerRadius = 18
        let xConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold)
        closeButton.setImage(UIImage(systemName: "xmark", withConfiguration: xConfig), for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        headerView.addSubview(closeButton)

        headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerTitleLabel.text = "New List"
        headerTitleLabel.font = Fonts.semibold17
        headerTitleLabel.textColor = Colors.primaryGrayText
        headerTitleLabel.textAlignment = .center
        headerView.addSubview(headerTitleLabel)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 52),

            closeButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Layout.spacingL),
            closeButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 36),
            closeButton.heightAnchor.constraint(equalToConstant: 36),

            headerTitleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerTitleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }

    private func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Create a list"
        titleLabel.font = Fonts.newItemIntroTitleFont
        titleLabel.textColor = Colors.primaryGrayText
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Name it, add a photo, and invite friends."
        subtitleLabel.font = Fonts.newItemIntroSubtitleFont
        subtitleLabel.textColor = Colors.subtleGrayText
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        view.addSubview(subtitleLabel)

        nameCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        nameCaptionLabel.text = "Name"
        nameCaptionLabel.font = Fonts.semibold14
        nameCaptionLabel.textColor = Colors.primaryGrayText
        view.addSubview(nameCaptionLabel)

        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholder = "Name your list"
        nameField.font = Fonts.regular16
        nameField.textColor = Colors.primaryGrayText
        nameField.backgroundColor = Colors.screenBackground
        nameField.layer.cornerRadius = fieldCornerRadius
        nameField.layer.borderWidth = 1
        nameField.layer.borderColor = Colors.newItemCardBorder.cgColor
        nameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Layout.spacingL, height: 1))
        nameField.leftViewMode = .always
        nameField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: Layout.spacingL, height: 1))
        nameField.rightViewMode = .always
        nameField.autocapitalizationType = .words
        nameField.returnKeyType = .done
        view.addSubview(nameField)

        groupImageView.translatesAutoresizingMaskIntoConstraints = false
        groupImageView.image = UIImage(named: "background_10")
        groupImageView.contentMode = .scaleAspectFill
        groupImageView.layer.cornerRadius = 16
        groupImageView.clipsToBounds = true
        groupImageView.backgroundColor = Colors.newItemInfoBackground
        view.addSubview(groupImageView)

        selectImageButton.translatesAutoresizingMaskIntoConstraints = false
        selectImageButton.setTitle("Select list photo", for: .normal)
        selectImageButton.setTitleColor(Colors.primaryBlue, for: .normal)
        selectImageButton.titleLabel?.font = Fonts.semibold15
        view.addSubview(selectImageButton)

        inviteCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        inviteCaptionLabel.text = "Invite friends"
        inviteCaptionLabel.font = Fonts.semibold14
        inviteCaptionLabel.textColor = Colors.primaryGrayText
        view.addSubview(inviteCaptionLabel)

        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle("Create list", for: .normal)
        createButton.titleLabel?.font = Fonts.semibold16
        createButton.layer.cornerRadius = 14
        createButton.clipsToBounds = true
        view.addSubview(createButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Layout.spacingL),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideInset),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.spacingS),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideInset),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideInset),

            nameCaptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Layout.spacingXL),
            nameCaptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideInset),
            nameCaptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideInset),

            nameField.topAnchor.constraint(equalTo: nameCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideInset),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideInset),
            nameField.heightAnchor.constraint(equalToConstant: 48),

            groupImageView.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: Layout.spacingXL),
            groupImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideInset),
            groupImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideInset),
            groupImageView.heightAnchor.constraint(equalToConstant: 150),

            selectImageButton.topAnchor.constraint(equalTo: groupImageView.bottomAnchor, constant: Layout.spacingS),
            selectImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            inviteCaptionLabel.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: Layout.spacingXL),
            inviteCaptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideInset),
            inviteCaptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideInset),

            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideInset),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideInset),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Layout.spacingL),
            createButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewGroupFriendTableViewCell.self, forCellReuseIdentifier: "NewGroupFriendTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Colors.screenBackground
        tableView.separatorColor = Colors.newItemCardBorder
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: inviteCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -Layout.spacingM)
        ])
    }
}

extension CreateGroupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewGroupFriendTableViewCell", for: indexPath) as? NewGroupFriendTableViewCell else {
            return UITableViewCell()
        }

        let friend = friends[indexPath.row]
        cell.configure(with: friend, isChecked: selectedUsernames.contains(friend.userName))
        cell.onCheckboxToggle = { [weak self] isChecked in
            guard let self else { return }
            if isChecked {
                self.selectedUsernames.insert(friend.userName)
            } else {
                self.selectedUsernames.remove(friend.userName)
            }
        }
        return cell
    }
}
