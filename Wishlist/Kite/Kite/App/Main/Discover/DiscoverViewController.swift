//
//  DiscoverViewController.swift
//  Kite
//
//  Created by David Vasquez on 9/19/25.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

class DiscoverViewController: UIViewController {

    //LOGIC
    private var selectedCategory: DiscoverCategory = .items
    private var lastBrowseCategory: DiscoverCategory = .items
    private var searchGeneration = 0
    private var browseGeneration = 0
    private var searchTask: Task<Void, Never>?
    private let searchAPI = SearchAPI.shared

    private let placeholderItems: [(title: String, category: String, imageName: String)] = [
        ("Super Mario RPG", "Video Games", "discover_1"),
        ("Zelda: Echoes of Wisdom", "Video Games", "discover_2"),
        ("Botanical Garden", "LEGO", "discover_3"),
        ("Retro Camera", "LEGO", "discover_4")
    ]

    //UI COMPONENTS
    // DiscoverViewController
    // ├── titleLabel
    // ├── searchBar
    // ├── categoryBar
    // └── scrollView
    //     └── contentStack

    private let titleLabel = UILabel()
    private let searchBar = DiscoverSearchBar()
    private let categoryBar = DiscoverTabBar()
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    //MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground
        setupViews()
        showCategory(.items)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "DiscoverViewController")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Discover"
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = Colors.primaryGrayText
        view.addSubview(titleLabel)

        view.addSubview(searchBar)
        view.addSubview(categoryBar)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(scrollView)

        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = Layout.spacingM
        scrollView.addSubview(contentStack)

        categoryBar.onSelect = { [weak self] category in
            self?.showCategory(category)
        }

        searchBar.onTextChange = { [weak self] text in
            self?.searchTextChanged(text)
        }

        layoutViews()
    }

    //LAYOUT and UI
    private func layoutViews() {
        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: Layout.spacingS),
            titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: Layout.spacingL),
            titleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Layout.spacingL),

            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.spacingL),
            searchBar.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            categoryBar.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: Layout.spacingL),
            categoryBar.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            categoryBar.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            scrollView.topAnchor.constraint(equalTo: categoryBar.bottomAnchor, constant: Layout.spacingXL),
            scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),

            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: Layout.spacingL),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -Layout.spacingL),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -Layout.spacingXL)
        ])
    }

    //ACTIONS
    private func showCategory(_ category: DiscoverCategory) {
        cancelSearch()
        lastBrowseCategory = category
        selectedCategory = category
        categoryBar.setSelectedCategory(category)
        searchBar.clearText()
        view.endEditing(true)
        reloadPlaceholders()
    }

    private func searchTextChanged(_ text: String) {
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines)
        cancelSearch()

        if query.isEmpty {
            selectedCategory = lastBrowseCategory
            categoryBar.setSelectedCategory(lastBrowseCategory)
            reloadPlaceholders()
            return
        }

        categoryBar.setSelectedCategory(nil)

        if query.count < 2 {
            showMessage("Keep typing to search people and lists.")
            return
        }

        showMessage("Searching…")
        let generation = searchGeneration
        searchTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 300_000_000)
            guard let self, !Task.isCancelled else { return }
            await self.performSearch(query: query, generation: generation)
        }
    }

    private func performSearch(query: String, generation: Int) async {
        async let peopleResult = loadPeople(query)
        async let listsResult = loadLists(query)
        let people = await peopleResult
        let lists = await listsResult

        await MainActor.run {
            guard generation == self.searchGeneration else { return }
            self.showSearchResults(query: query, people: people, lists: lists)
        }
    }

    private func loadPeople(_ query: String) async -> Result<[SearchUserResult], Error> {
        do {
            return .success(try await searchAPI.searchUsers(searchString: query))
        } catch {
            return .failure(error)
        }
    }

    private func loadLists(_ query: String) async -> Result<[SearchGroupResult], Error> {
        do {
            return .success(try await searchAPI.searchGroups(searchString: query))
        } catch {
            return .failure(error)
        }
    }

    @objc private func itemTapped(_ sender: DiscoverItem) {
        print("Discover item tapped: \(sender.accessibilityLabel ?? "")")
    }

    @objc private func userTapped(_ sender: DiscoverUser) {
        guard let person = sender.searchResult, !person.username.isEmpty else {
            print("Discover person tapped: \(sender.accessibilityLabel ?? "")")
            return
        }

        let firstName = person.firstName.isEmpty ? person.username : person.firstName
        let lastName = person.lastName.isEmpty ? " " : person.lastName
        let user = User(
            userID: person.userID,
            userName: person.username,
            userImage: person.imageURL,
            firstName: firstName,
            lastName: lastName
        )

        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        guard let profile = storyboard.instantiateViewController(withIdentifier: "FriendProfileViewControllerID") as? FriendProfileViewController else {
            return
        }
        profile.friend = user
        navigationController?.pushViewController(profile, animated: true)
    }

    @objc private func listTapped(_ sender: DiscoverList) {
        print("Discover list tapped: \(sender.accessibilityLabel ?? "")")
    }

    //FUNCTIONS
    private func cancelSearch() {
        searchTask?.cancel()
        searchTask = nil
        searchGeneration += 1
    }

    private func clearContent() {
        contentStack.arrangedSubviews.forEach { view in
            contentStack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

    private func reloadPlaceholders() {
        browseGeneration += 1
        let generation = browseGeneration
        clearContent()

        switch selectedCategory {
        case .items:
            contentStack.addArrangedSubview(sectionTitle("Discover something fun"))
            contentStack.addArrangedSubview(itemGrid())
        case .people:
            contentStack.addArrangedSubview(sectionTitle("People"))
            contentStack.addArrangedSubview(caption("Loading friends…"))
            Task { [weak self] in
                await self?.loadFriends(generation: generation)
            }
        case .lists:
            contentStack.addArrangedSubview(sectionTitle("Lists"))
            contentStack.addArrangedSubview(caption("Loading lists…"))
            Task { [weak self] in
                await self?.loadDiscoverLists(generation: generation)
            }
        }
    }

    private func loadFriends(generation: Int) async {
        do {
            _ = try await UsersDataController.shared.fetchFriends()
        } catch {
            await MainActor.run {
                guard generation == self.browseGeneration, self.selectedCategory == .people else { return }
                self.showMessage("Couldn't load friends.")
            }
            return
        }

        let friends = UsersDataController.shared.splitFriendsByStatus().friends.sorted {
            $0.displayName.localizedCaseInsensitiveCompare($1.displayName) == .orderedAscending
        }

        await MainActor.run {
            guard generation == self.browseGeneration, self.selectedCategory == .people else { return }
            self.clearContent()
            self.contentStack.addArrangedSubview(self.sectionTitle("People"))
            if friends.isEmpty {
                self.contentStack.addArrangedSubview(self.caption("No friends yet."))
                return
            }
            friends.forEach { friend in
                let row = DiscoverUser()
                let username = friend.userName.isEmpty ? "" : "@\(friend.userName)"
                row.configure(name: friend.displayName, username: username, image: friend.profileImage)
                row.addTarget(self, action: #selector(self.userTapped(_:)), for: .touchUpInside)
                self.contentStack.addArrangedSubview(row)
            }
        }
    }

    private func loadDiscoverLists(generation: Int) async {
        let outcome: (Bool, [GroupModel]) = await withCheckedContinuation { continuation in
            GroupDataController.shared.getGroups { success in
                let lists = GroupDataController.shared.groups.filter {
                    $0.groupType.lowercased() == "wishlist"
                }
                continuation.resume(returning: (success, lists))
            }
        }

        await MainActor.run {
            guard generation == self.browseGeneration, self.selectedCategory == .lists else { return }
            self.clearContent()
            self.contentStack.addArrangedSubview(self.sectionTitle("Lists"))
            if !outcome.0 {
                self.contentStack.addArrangedSubview(self.caption("Couldn't load lists."))
                return
            }
            if outcome.1.isEmpty {
                self.contentStack.addArrangedSubview(self.caption("No lists yet."))
                return
            }
            outcome.1.forEach { list in
                let row = DiscoverList()
                row.configure(title: list.groupName, detail: self.listDetail(for: list))
                row.addTarget(self, action: #selector(self.listTapped(_:)), for: .touchUpInside)
                self.contentStack.addArrangedSubview(row)
                self.loadListCover(list, into: row, generation: generation)
            }
        }
    }

    private func loadSearchAvatar(_ person: SearchUserResult, into row: DiscoverUser, generation: Int) {
        Task { [weak row] in
            let image = await searchAvatarImage(for: person)
            await MainActor.run {
                guard generation == self.searchGeneration, let image else { return }
                let username = person.username.isEmpty ? "" : "@\(person.username)"
                row?.configure(name: person.name, username: username, image: image)
            }
        }
    }

    private func searchAvatarImage(for person: SearchUserResult) async -> UIImage? {
        if let user = await UsersDataController.shared.getOrFetchUserWithImage(username: person.username),
           let image = await downloadedProfileImage(from: user.userImage) {
            return image
        }
        return await downloadedProfileImage(from: person.imageURL)
    }

    private func downloadedProfileImage(from urlString: String) async -> UIImage? {
        let imageURL = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        guard imageURL.hasPrefix("http://") || imageURL.hasPrefix("https://") else { return nil }
        return await ImageCacheManager.shared.fetchImageIfNeeded(from: imageURL)
    }

    private func loadListCover(_ list: GroupModel, into row: DiscoverList, generation: Int) {
        let imageURL = list.groupImage
        Task { [weak row] in
            guard let imageURL,
                  let image = await ImageCacheManager.shared.fetchImageIfNeeded(from: imageURL) else { return }
            await MainActor.run {
                guard generation == self.browseGeneration else { return }
                row?.setCoverImage(image)
            }
        }
    }

    private func listDetail(for list: GroupModel) -> String {
        var seen = Set<String>()
        for member in list.activeGroupMembers {
            let name = member.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            if !name.isEmpty {
                seen.insert(name)
            }
        }
        let memberText = seen.count == 1 ? "1 member" : "\(seen.count) members"
        if let createdBy = list.createdBy, !createdBy.isEmpty {
            return "\(memberText) · by \(createdBy)"
        }
        return memberText
    }

    private func isFailed<T>(_ result: Result<T, Error>) -> Bool {
        if case .failure = result {
            return true
        }
        return false
    }

    private func showMessage(_ text: String) {
        clearContent()
        contentStack.addArrangedSubview(caption(text))
    }

    private func showSearchResults(
        query: String,
        people: Result<[SearchUserResult], Error>,
        lists: Result<[SearchGroupResult], Error>
    ) {
        clearContent()
        contentStack.addArrangedSubview(sectionTitle("Search results"))

        let peopleRows = (try? people.get()) ?? []
        let listRows = (try? lists.get()) ?? []
        let visibleCount = peopleRows.count + listRows.count
        let peopleFailed = isFailed(people)
        let listsFailed = isFailed(lists)
        let bothFailed = peopleFailed && listsFailed

        if bothFailed {
            contentStack.addArrangedSubview(caption("Search failed. Try again."))
            return
        }

        if visibleCount == 0 && !peopleFailed && !listsFailed {
            contentStack.addArrangedSubview(caption("No people or lists found for “\(query)”"))
            return
        }

        if visibleCount > 0 {
            contentStack.addArrangedSubview(caption("\(visibleCount) results for “\(query)”"))
        }

        if peopleFailed {
            contentStack.addArrangedSubview(sectionGroup(
                label: "PEOPLE",
                message: "People search failed."
            ))
        } else if !peopleRows.isEmpty {
            let group = sectionGroup(label: "PEOPLE")
            let generation = searchGeneration
            peopleRows.forEach { person in
                let row = DiscoverUser()
                let username = person.username.isEmpty ? "" : "@\(person.username)"
                row.searchResult = person
                row.configure(name: person.name, username: username)
                row.addTarget(self, action: #selector(userTapped(_:)), for: .touchUpInside)
                group.addArrangedSubview(row)
                loadSearchAvatar(person, into: row, generation: generation)
            }
            contentStack.addArrangedSubview(group)
        }

        if listsFailed {
            contentStack.addArrangedSubview(sectionGroup(
                label: "LISTS",
                message: "List search failed."
            ))
        } else if !listRows.isEmpty {
            let group = sectionGroup(label: "LISTS")
            listRows.forEach { list in
                let row = DiscoverList()
                row.configure(title: list.title, detail: list.detail)
                row.addTarget(self, action: #selector(listTapped(_:)), for: .touchUpInside)
                group.addArrangedSubview(row)
            }
            contentStack.addArrangedSubview(group)
        }
    }

    private func sectionTitle(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = Colors.primaryGrayText
        return label
    }

    private func caption(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = Fonts.regular15
        label.textColor = Colors.subtleGrayText
        label.numberOfLines = 0
        return label
    }

    private func sectionGroup(label: String, message: String? = nil) -> UIStackView {
        let group = UIStackView()
        group.axis = .vertical
        group.spacing = Layout.spacingS

        let heading = UILabel()
        heading.text = label
        heading.font = Fonts.regular12
        heading.textColor = Colors.subtleGrayText
        group.addArrangedSubview(heading)

        if let message = message {
            group.addArrangedSubview(caption(message))
        }

        return group
    }

    private func itemGrid() -> UIStackView {
        let grid = UIStackView()
        grid.axis = .vertical
        grid.spacing = Layout.spacingM

        var index = 0
        while index < placeholderItems.count {
            let row = UIStackView()
            row.axis = .horizontal
            row.spacing = Layout.spacingM
            row.distribution = .fillEqually
            row.addArrangedSubview(itemCard(placeholderItems[index]))
            if index + 1 < placeholderItems.count {
                row.addArrangedSubview(itemCard(placeholderItems[index + 1]))
            }
            grid.addArrangedSubview(row)
            index += 2
        }

        return grid
    }

    private func itemCard(_ item: (title: String, category: String, imageName: String)) -> DiscoverItem {
        let card = DiscoverItem()
        card.configure(title: item.title, category: item.category, imageName: item.imageName)
        card.addTarget(self, action: #selector(itemTapped(_:)), for: .touchUpInside)
        card.onAdd = { [weak card] in
            guard let card = card else { return }
            print("Discover item add tapped: \(card.accessibilityLabel ?? "")")
        }
        return card
    }
}
