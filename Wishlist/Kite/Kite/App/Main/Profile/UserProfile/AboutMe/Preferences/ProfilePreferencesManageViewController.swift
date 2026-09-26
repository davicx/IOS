//
//  ProfilePreferencesManageViewController.swift
//  Kite
//
//  Created by David Vasquez on 9/9/26.
//

import UIKit


/// Edit Clothing & Sizes bottom sheet root — list + Add Preference.
final class ProfilePreferencesManageViewController: UIViewController {

    //LOGIC
    var userName: String = ""
    private let preferenceDataController = ProfilePreferenceDataController.shared
    private var preferences: [ProfilePreference] = []

    //UI COMPONENTS
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let addPreferenceButton = UIButton(type: .system)

    //MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.feedBackground
        setupNavigation()
        setupTable()
        setupAddButton()
        reloadFromController()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePreferencesUpdated),
            name: .preferencesUpdated,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupNavigation() {
        title = "Clothing & Sizes"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneTapped)
        )
    }

    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.feedBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PreferenceCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        view.addSubview(tableView)
    }

    private func setupAddButton() {
        addPreferenceButton.translatesAutoresizingMaskIntoConstraints = false
        addPreferenceButton.setTitle("+ Add Preference", for: .normal)
        addPreferenceButton.backgroundColor = Colors.primaryBlue.withAlphaComponent(0.08)
        addPreferenceButton.setTitleColor(Colors.primaryBlue, for: .normal)
        addPreferenceButton.titleLabel?.font = Fonts.semibold17
        addPreferenceButton.layer.cornerRadius = 16
        addPreferenceButton.clipsToBounds = true
        addPreferenceButton.addTarget(self, action: #selector(addPreferenceTapped), for: .touchUpInside)
        view.addSubview(addPreferenceButton)

        NSLayoutConstraint.activate([
            addPreferenceButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.spacingL),
            addPreferenceButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.spacingL),
            addPreferenceButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Layout.spacingM),
            addPreferenceButton.heightAnchor.constraint(equalToConstant: 56),

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addPreferenceButton.topAnchor, constant: -Layout.spacingM)
        ])
    }

    //ACTIONS
    @objc private func doneTapped() {
        dismiss(animated: true)
    }

    @objc private func addPreferenceTapped() {
        let form = ProfilePreferenceFormViewController(mode: .add)
        form.userName = userName
        navigationController?.pushViewController(form, animated: true)
    }

    @objc private func handlePreferencesUpdated(_ notification: Notification) {
        if let updatedUser = notification.userInfo?["userName"] as? String,
           !updatedUser.isEmpty,
           updatedUser != userName {
            return
        }
        reloadFromController()
    }

    //FUNCTIONS
    private func reloadFromController() {
        preferences = preferenceDataController.preferences(for: userName)
        tableView.reloadData()
    }

    func openAddFormIfNeeded(openAdd: Bool) {
        guard openAdd else { return }
        DispatchQueue.main.async { [weak self] in
            self?.addPreferenceTapped()
        }
    }
}

extension ProfilePreferencesManageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        preferences.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreferenceCell", for: indexPath)
        let preference = preferences[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = preference.preferenceCategory
        content.secondaryText = preference.preferenceTitle
        content.textProperties.color = Colors.subtleGrayText
        content.textProperties.font = Fonts.semibold16
        content.secondaryTextProperties.color = Colors.primaryGrayText
        content.secondaryTextProperties.font = Fonts.semibold17
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .default
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let preference = preferences[indexPath.row]
        let form = ProfilePreferenceFormViewController(mode: .edit(preference))
        form.userName = userName
        navigationController?.pushViewController(form, animated: true)
    }
}
