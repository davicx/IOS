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
    private var searchTask: Task<Void, Never>?
    private let searchAPI = SearchAPI.shared

    private let placeholderItems: [(title: String, category: String, imageName: String)] = [
        ("Super Mario RPG", "Video Games", "discover_1"),
        ("Zelda: Echoes of Wisdom", "Video Games", "discover_2"),
        ("Botanical Garden", "LEGO", "discover_3"),
        ("Retro Camera", "LEGO", "discover_4")
    ]

    private let placeholderPeople: [(name: String, username: String)] = [
        ("Sarah Miller", "@sarahm"),
        ("Sam", "@sam"),
        ("Maya Chen", "@mayac"),
        ("Alex Rivera", "@alexr")
    ]

    private let placeholderLists: [(title: String, detail: String)] = [
        ("Cozy Game Night", "12 items · by alex"),
        ("Sam's Cool List", "8 items · by Sam"),
        ("Weekend Wishlist", "6 items · by maya"),
        ("Retro Finds", "4 items · by jordan")
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
        print("Discover person tapped: \(sender.accessibilityLabel ?? "")")
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
        clearContent()

        switch selectedCategory {
        case .items:
            contentStack.addArrangedSubview(sectionTitle("Discover something fun"))
            contentStack.addArrangedSubview(itemGrid())
        case .people:
            contentStack.addArrangedSubview(sectionTitle("People"))
            placeholderPeople.forEach { person in
                let row = DiscoverUser()
                row.configure(name: person.name, username: person.username)
                row.addTarget(self, action: #selector(userTapped(_:)), for: .touchUpInside)
                contentStack.addArrangedSubview(row)
            }
        case .lists:
            contentStack.addArrangedSubview(sectionTitle("Lists"))
            placeholderLists.forEach { list in
                let row = DiscoverList()
                row.configure(title: list.title, detail: list.detail)
                row.addTarget(self, action: #selector(listTapped(_:)), for: .touchUpInside)
                contentStack.addArrangedSubview(row)
            }
        }
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
            peopleRows.forEach { person in
                let row = DiscoverUser()
                let username = person.username.isEmpty ? "" : "@\(person.username)"
                row.configure(name: person.name, username: username)
                row.addTarget(self, action: #selector(userTapped(_:)), for: .touchUpInside)
                group.addArrangedSubview(row)
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
