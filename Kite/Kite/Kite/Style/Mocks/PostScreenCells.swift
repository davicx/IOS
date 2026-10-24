//
//  PostScreenCells.swift
//  Kite
//
//  Record of the post cells used by Home, an individual post, and a group.
//  Every line below is commented out so this file does not compile into the app.
//

// =============================================================================
// HEADER: HomeViewController
// Live cell: DesignPostCell
// Style: DesignStyleTemp
// Also registered, not returned: PostCell
// Commented out in the controller, not used: HomePostCell
// =============================================================================
//
// CODE
// Source: App/Main/HomeViewController.swift
//
// func setupTableView() {
//     postsTableView.delegate = self
//     postsTableView.dataSource = self
//     postsTableView.register(PostCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifier.postCell)
//     postsTableView.register(DesignPostCell.self, forCellReuseIdentifier: "DesignPostCell")
//     postsTableView.rowHeight = UITableView.automaticDimension
//     postsTableView.separatorStyle = .none
//     postsTableView.backgroundColor = Colors.feedBackground
//     postsTableView.backgroundColor = DesignStyleTemp.background
//     //postsTableView.register(HomePostCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifier.homePostCell)
// }
//
// func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//     return DesignPostCell.previewPosts.count
// }
//
// func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//     let cell = tableView.dequeueReusableCell(withIdentifier: "DesignPostCell", for: indexPath) as! DesignPostCell
//     cell.configure(with: DesignPostCell.previewPosts[indexPath.row])
//     cell.onLayoutChange = { [weak tableView] in
//         UIView.performWithoutAnimation {
//             tableView?.beginUpdates()
//             tableView?.endUpdates()
//         }
//     }
//     return cell
// }
//
// func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//     return UITableView.automaticDimension
// }
//
// CELL: DesignPostCell
// Source: App/Main/Post/Cells/DesignPostCell.swift
//
// //
// //  DesignPostCell.swift
// //  Kite
// //
// //  Instagram-style post layout for design review.
// //  All of this layout lives in this file. Styles live in DesignStyleTemp.
// //
//
// import UIKit
//
//
// //LOGIC
// //UI COMPONENTS
// //MANAGE VIEWS
// //LAYOUT and UI
// //ACTIONS
// //FUNCTIONS
//
// final class DesignPostCell: UITableViewCell {
//
//     //LOGIC
//     struct Preview {
//         let id: String
//         let username: String
//         let audio: String?
//         let imageName: String
//         let pageCount: Int
//         let likeCount: Int
//         let caption: String
//         let date: Date
//     }
//
//     static let previewPosts: [Preview] = [
//         Preview(
//             id: "design-post-1",
//             username: "ghibli.style",
//             audio: nil,
//             imageName: "background_10",
//             pageCount: 4,
//             likeCount: 39820,
//             caption: "Can you guess this Ghibli movie? 💚\nDouble tap if you find them cute!\nTag someone who needs to see this 👆🏻",
//             date: previewDate(year: 2024, month: 11, day: 20)
//         ),
//         Preview(
//             id: "design-post-2",
//             username: "ghibli.style",
//             audio: "ghibli.style · Original audio",
//             imageName: "background_10",
//             pageCount: 1,
//             likeCount: 1204,
//             caption: "Second post, so the white space before the next header is visible.",
//             date: previewDate(year: 2024, month: 11, day: 18)
//         )
//     ]
//
//     private static var expandedPostIDs = Set<String>()
//     private static var likedPostIDs = Set<String>()
//     private static var savedPostIDs = Set<String>()
//     private static var pageByPostID = [String: Int]()
//
//     private var preview: Preview?
//     private var lastCaptionWidth: CGFloat = 0
//     var onLayoutChange: (() -> Void)?
//
//     //UI COMPONENTS
//     private let postHeader = DesignPostHeader()
//     private let postMedia = DesignPostMedia()
//     private let postActions = DesignPostActions()
//     private let postLikes = UILabel()
//     private let postCaption = UILabel()
//     private let postDate = UILabel()
//
//     private let likeFormatter: NumberFormatter = {
//         let formatter = NumberFormatter()
//         formatter.numberStyle = .decimal
//         return formatter
//     }()
//
//     private let dateFormatter: DateFormatter = {
//         let formatter = DateFormatter()
//         formatter.locale = .current
//         formatter.dateFormat = "MMMM d, yyyy"
//         return formatter
//     }()
//
//     //MANAGE VIEWS
//     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//         super.init(style: style, reuseIdentifier: reuseIdentifier)
//         selectionStyle = .none
//         backgroundColor = DesignStyleTemp.background
//         contentView.backgroundColor = DesignStyleTemp.background
//         setupLayout()
//         postActions.onLike = { [weak self] in self?.toggleLike() }
//         postActions.onSave = { [weak self] in self?.toggleSave() }
//         postMedia.onPageChange = { [weak self] page in self?.storePage(page) }
//         postMedia.onDoubleTap = { [weak self] in self?.likeFromDoubleTap() }
//         let captionTap = UITapGestureRecognizer(target: self, action: #selector(captionTapped))
//         postCaption.addGestureRecognizer(captionTap)
//         postCaption.isUserInteractionEnabled = true
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//
//     override func layoutSubviews() {
//         super.layoutSubviews()
//         let width = contentView.bounds.width
//         guard width > 0, abs(width - lastCaptionWidth) > 0.5 else { return }
//         lastCaptionWidth = width
//         applyCaption()
//     }
//
//     override func prepareForReuse() {
//         super.prepareForReuse()
//         preview = nil
//         lastCaptionWidth = 0
//         onLayoutChange = nil
//         postHeader.prepareForReuse()
//         postMedia.prepareForReuse()
//         postActions.prepareForReuse()
//         postLikes.text = nil
//         postCaption.attributedText = nil
//         postDate.text = nil
//     }
//
//     func configure(with preview: Preview) {
//         self.preview = preview
//         let liked = Self.likedPostIDs.contains(preview.id)
//         let saved = Self.savedPostIDs.contains(preview.id)
//         let page = Self.pageByPostID[preview.id] ?? 0
//         postHeader.configure(username: preview.username, imageName: preview.imageName, audio: preview.audio)
//         postMedia.configure(imageName: preview.imageName, pageCount: preview.pageCount, page: page)
//         postActions.configure(pageCount: preview.pageCount, page: page, liked: liked, saved: saved)
//         postLikes.text = likeText(preview.likeCount + (liked ? 1 : 0))
//         postDate.text = dateFormatter.string(from: preview.date)
//         applyCaption()
//     }
//
//     //LAYOUT and UI
//     private func setupLayout() {
//         postLikes.font = DesignStyleTemp.likeCountFont
//         postLikes.textColor = DesignStyleTemp.primaryText
//         postDate.font = DesignStyleTemp.dateFont
//         postDate.textColor = DesignStyleTemp.secondaryText
//         postCaption.numberOfLines = 0
//
//         [postHeader, postMedia, postActions, postLikes, postCaption, postDate].forEach {
//             $0.translatesAutoresizingMaskIntoConstraints = false
//             contentView.addSubview($0)
//         }
//
//         NSLayoutConstraint.activate([
//             postHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
//             postHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             postHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//             postHeader.heightAnchor.constraint(equalToConstant: DesignStyleTemp.headerHeight),
//
//             postMedia.topAnchor.constraint(equalTo: postHeader.bottomAnchor),
//             postMedia.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             postMedia.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//
//             postActions.topAnchor.constraint(equalTo: postMedia.bottomAnchor),
//             postActions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             postActions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//             postActions.heightAnchor.constraint(equalToConstant: DesignStyleTemp.actionsHeight),
//
//             postLikes.topAnchor.constraint(equalTo: postActions.bottomAnchor, constant: DesignStyleTemp.likesTop),
//             postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DesignStyleTemp.textInset),
//             postLikes.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DesignStyleTemp.textInset),
//
//             postCaption.topAnchor.constraint(equalTo: postLikes.bottomAnchor, constant: DesignStyleTemp.captionTop),
//             postCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DesignStyleTemp.textInset),
//             postCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DesignStyleTemp.textInset),
//
//             postDate.topAnchor.constraint(equalTo: postCaption.bottomAnchor, constant: DesignStyleTemp.dateTop),
//             postDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DesignStyleTemp.textInset),
//             postDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DesignStyleTemp.textInset),
//             postDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -DesignStyleTemp.postBottom)
//         ])
//     }
//
//     //ACTIONS
//     private func toggleLike() {
//         guard let preview else { return }
//         if Self.likedPostIDs.contains(preview.id) {
//             Self.likedPostIDs.remove(preview.id)
//         } else {
//             Self.likedPostIDs.insert(preview.id)
//         }
//         refreshLike(animated: true)
//     }
//
//     private func likeFromDoubleTap() {
//         guard let preview else { return }
//         Self.likedPostIDs.insert(preview.id)
//         refreshLike(animated: true)
//         postMedia.showLikeHeart()
//     }
//
//     private func toggleSave() {
//         guard let preview else { return }
//         if Self.savedPostIDs.contains(preview.id) {
//             Self.savedPostIDs.remove(preview.id)
//         } else {
//             Self.savedPostIDs.insert(preview.id)
//         }
//         let saved = Self.savedPostIDs.contains(preview.id)
//         postActions.setSaved(saved)
//     }
//
//     @objc private func captionTapped() {
//         guard let preview, showsMore else { return }
//         if Self.expandedPostIDs.contains(preview.id) { return }
//         Self.expandedPostIDs.insert(preview.id)
//         applyCaption()
//         onLayoutChange?()
//     }
//
//     //FUNCTIONS
//     private func storePage(_ page: Int) {
//         guard let preview else { return }
//         Self.pageByPostID[preview.id] = page
//         postActions.setPage(page, count: preview.pageCount)
//     }
//
//     private func refreshLike(animated: Bool) {
//         guard let preview else { return }
//         let liked = Self.likedPostIDs.contains(preview.id)
//         postActions.setLiked(liked, animated: animated)
//         postLikes.text = likeText(preview.likeCount + (liked ? 1 : 0))
//     }
//
//     private func likeText(_ count: Int) -> String {
//         let number = likeFormatter.string(from: NSNumber(value: count)) ?? "\(count)"
//         return count == 1 ? "\(number) like" : "\(number) likes"
//     }
//
//     private var showsMore: Bool {
//         guard let preview else { return false }
//         return !Self.expandedPostIDs.contains(preview.id) && captionNeedsMore(preview)
//     }
//
//     private func applyCaption() {
//         guard let preview else { return }
//         let expanded = Self.expandedPostIDs.contains(preview.id)
//         if expanded || !captionNeedsMore(preview) {
//             postCaption.attributedText = captionString(username: preview.username, caption: preview.caption, more: false)
//         } else {
//             postCaption.attributedText = collapsedCaption(username: preview.username, caption: preview.caption)
//         }
//     }
//
//     private func captionNeedsMore(_ preview: Preview) -> Bool {
//         let full = captionString(username: preview.username, caption: preview.caption, more: false)
//         let width = max(contentView.bounds.width - (DesignStyleTemp.textInset * 2), 1)
//         let height = full.boundingRect(
//             with: CGSize(width: width, height: .greatestFiniteMagnitude),
//             options: [.usesLineFragmentOrigin, .usesFontLeading],
//             context: nil
//         ).height
//         let limit = (DesignStyleTemp.captionFont.lineHeight * CGFloat(DesignStyleTemp.maxCaptionLines)) + (DesignStyleTemp.captionLineSpacing * 2)
//         return height > limit + 1
//     }
//
//     private func collapsedCaption(username: String, caption: String) -> NSAttributedString {
//         let more = " ... more"
//         var low = 0
//         var high = caption.count
//         var best = ""
//         while low <= high {
//             let mid = (low + high) / 2
//             let slice = String(caption.prefix(mid)).trimmingCharacters(in: .whitespacesAndNewlines)
//             let candidate = captionString(username: username, caption: slice, more: true)
//             let width = max(contentView.bounds.width - (DesignStyleTemp.textInset * 2), 1)
//             let height = candidate.boundingRect(
//                 with: CGSize(width: width, height: .greatestFiniteMagnitude),
//                 options: [.usesLineFragmentOrigin, .usesFontLeading],
//                 context: nil
//             ).height
//             let limit = (DesignStyleTemp.captionFont.lineHeight * CGFloat(DesignStyleTemp.maxCaptionLines)) + (DesignStyleTemp.captionLineSpacing * 2)
//             if height <= limit + 1 {
//                 best = slice
//                 low = mid + 1
//             } else {
//                 high = mid - 1
//             }
//         }
//         if best.isEmpty {
//             best = String(caption.prefix(40))
//         }
//         _ = more
//         return captionString(username: username, caption: best, more: true)
//     }
//
//     private func captionString(username: String, caption: String, more: Bool) -> NSAttributedString {
//         let text = NSMutableAttributedString()
//         text.append(NSAttributedString(string: username, attributes: [
//             .font: DesignStyleTemp.usernameFont,
//             .foregroundColor: DesignStyleTemp.primaryText
//         ]))
//         text.append(NSAttributedString(string: " " + caption, attributes: [
//             .font: DesignStyleTemp.captionFont,
//             .foregroundColor: DesignStyleTemp.primaryText
//         ]))
//         if more {
//             text.append(NSAttributedString(string: " ... more", attributes: [
//                 .font: DesignStyleTemp.moreFont,
//                 .foregroundColor: DesignStyleTemp.secondaryText
//             ]))
//         }
//         let paragraph = NSMutableParagraphStyle()
//         paragraph.lineSpacing = DesignStyleTemp.captionLineSpacing
//         text.addAttribute(.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: text.length))
//         return text
//     }
//
//     private static func previewDate(year: Int, month: Int, day: Int) -> Date {
//         var components = DateComponents()
//         components.year = year
//         components.month = month
//         components.day = day
//         return Calendar.current.date(from: components) ?? Date()
//     }
// }
//
//
// //UI COMPONENTS
//
// private final class DesignPostHeader: UIView {
//
//     private let avatarImageView = UIImageView()
//     private let usernameLabel = UILabel()
//     private let audioIcon = UIImageView()
//     private let audioLabel = UILabel()
//     private let audioRow = UIStackView()
//     private let nameStack = UIStackView()
//     private let menuButton = UIButton(type: .system)
//
//     override init(frame: CGRect) {
//         super.init(frame: frame)
//         backgroundColor = DesignStyleTemp.background
//
//         avatarImageView.contentMode = .scaleAspectFill
//         avatarImageView.clipsToBounds = true
//         avatarImageView.layer.cornerRadius = DesignStyleTemp.avatarSize / 2
//
//         usernameLabel.font = DesignStyleTemp.usernameFont
//         usernameLabel.textColor = DesignStyleTemp.primaryText
//
//         audioIcon.image = UIImage(systemName: "music.note")
//         audioIcon.tintColor = DesignStyleTemp.secondaryText
//         audioIcon.contentMode = .scaleAspectFit
//         audioLabel.font = DesignStyleTemp.audioFont
//         audioLabel.textColor = DesignStyleTemp.secondaryText
//
//         audioRow.axis = .horizontal
//         audioRow.spacing = 4
//         audioRow.alignment = .center
//         audioRow.addArrangedSubview(audioIcon)
//         audioRow.addArrangedSubview(audioLabel)
//
//         nameStack.axis = .vertical
//         nameStack.spacing = 1
//         nameStack.alignment = .leading
//         nameStack.addArrangedSubview(usernameLabel)
//         nameStack.addArrangedSubview(audioRow)
//
//         menuButton.setImage(DesignStyleTemp.outlineIcon("ellipsis"), for: .normal)
//         menuButton.tintColor = DesignStyleTemp.primaryText
//
//         [avatarImageView, nameStack, menuButton].forEach {
//             $0.translatesAutoresizingMaskIntoConstraints = false
//             addSubview($0)
//         }
//
//         NSLayoutConstraint.activate([
//             avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DesignStyleTemp.headerLeading),
//             avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//             avatarImageView.widthAnchor.constraint(equalToConstant: DesignStyleTemp.avatarSize),
//             avatarImageView.heightAnchor.constraint(equalToConstant: DesignStyleTemp.avatarSize),
//
//             nameStack.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: DesignStyleTemp.avatarToUsername),
//             nameStack.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
//             nameStack.trailingAnchor.constraint(lessThanOrEqualTo: menuButton.leadingAnchor, constant: -8),
//
//             audioIcon.widthAnchor.constraint(equalToConstant: 12),
//             audioIcon.heightAnchor.constraint(equalToConstant: 12),
//
//             menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DesignStyleTemp.headerTrailing),
//             menuButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//             menuButton.widthAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
//             menuButton.heightAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget)
//         ])
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//
//     func configure(username: String, imageName: String, audio: String?) {
//         usernameLabel.text = username
//         avatarImageView.image = UIImage(named: imageName)
//         audioLabel.text = audio
//         audioRow.isHidden = audio == nil
//     }
//
//     func prepareForReuse() {
//         avatarImageView.image = nil
//         usernameLabel.text = nil
//         audioLabel.text = nil
//         audioRow.isHidden = true
//     }
// }
//
//
// private final class DesignPostMedia: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//     var onPageChange: ((Int) -> Void)?
//     var onDoubleTap: (() -> Void)?
//
//     private var imageName = "background_10"
//     private var pageCount = 1
//     private var currentPage = 0
//     private var pendingPage = 0
//
//     private let layout = UICollectionViewFlowLayout()
//     private lazy var collectionView: UICollectionView = {
//         layout.scrollDirection = .horizontal
//         layout.minimumLineSpacing = 0
//         layout.minimumInteritemSpacing = 0
//         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//         collectionView.isPagingEnabled = true
//         collectionView.showsHorizontalScrollIndicator = false
//         collectionView.backgroundColor = .clear
//         collectionView.alwaysBounceVertical = false
//         collectionView.isDirectionalLockEnabled = true
//         collectionView.dataSource = self
//         collectionView.delegate = self
//         collectionView.register(DesignPostMediaPageCell.self, forCellWithReuseIdentifier: "DesignPostMediaPageCell")
//         return collectionView
//     }()
//
//     private let pageCounter = UILabel()
//     private let likeHeart = UIImageView()
//     private var heightConstraint: NSLayoutConstraint?
//
//     override init(frame: CGRect) {
//         super.init(frame: frame)
//         backgroundColor = DesignStyleTemp.background
//         clipsToBounds = true
//
//         collectionView.translatesAutoresizingMaskIntoConstraints = false
//         addSubview(collectionView)
//
//         pageCounter.font = DesignStyleTemp.pageCounterFont
//         pageCounter.textColor = .white
//         pageCounter.textAlignment = .center
//         pageCounter.backgroundColor = DesignStyleTemp.pageCounterBackground
//         pageCounter.layer.cornerRadius = DesignStyleTemp.pageCounterHeight / 2
//         pageCounter.clipsToBounds = true
//         pageCounter.translatesAutoresizingMaskIntoConstraints = false
//         addSubview(pageCounter)
//
//         likeHeart.image = DesignStyleTemp.outlineIcon("heart.fill")
//         likeHeart.tintColor = .white
//         likeHeart.alpha = 0
//         likeHeart.translatesAutoresizingMaskIntoConstraints = false
//         addSubview(likeHeart)
//
//         let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
//         doubleTap.numberOfTapsRequired = 2
//         collectionView.addGestureRecognizer(doubleTap)
//
//         heightConstraint = heightAnchor.constraint(equalToConstant: 262)
//         heightConstraint?.isActive = true
//
//         NSLayoutConstraint.activate([
//             collectionView.topAnchor.constraint(equalTo: topAnchor),
//             collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
//             collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//             collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//             pageCounter.topAnchor.constraint(equalTo: topAnchor, constant: DesignStyleTemp.pageCounterTop),
//             pageCounter.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DesignStyleTemp.pageCounterTrailing),
//             pageCounter.heightAnchor.constraint(equalToConstant: DesignStyleTemp.pageCounterHeight),
//
//             likeHeart.centerXAnchor.constraint(equalTo: centerXAnchor),
//             likeHeart.centerYAnchor.constraint(equalTo: centerYAnchor),
//             likeHeart.widthAnchor.constraint(equalToConstant: 88),
//             likeHeart.heightAnchor.constraint(equalToConstant: 88)
//         ])
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//
//     override func layoutSubviews() {
//         super.layoutSubviews()
//         let width = bounds.width
//         guard width > 0 else { return }
//         let height = width / DesignStyleTemp.mediaAspect
//         if heightConstraint?.constant != height {
//             heightConstraint?.constant = height
//         }
//         let pageSize = CGSize(width: width, height: bounds.height)
//         if layout.itemSize != pageSize {
//             layout.itemSize = pageSize
//             layout.invalidateLayout()
//         }
//         let offset = CGFloat(pendingPage) * width
//         if abs(collectionView.contentOffset.x - offset) > 1, !collectionView.isDragging {
//             collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
//         }
//     }
//
//     func configure(imageName: String, pageCount: Int, page: Int) {
//         self.imageName = imageName
//         self.pageCount = max(pageCount, 1)
//         currentPage = min(page, self.pageCount - 1)
//         pendingPage = currentPage
//         pageCounter.isHidden = self.pageCount < 2
//         pageCounter.text = "  \(currentPage + 1)/\(self.pageCount)  "
//         collectionView.reloadData()
//         setNeedsLayout()
//     }
//
//     func prepareForReuse() {
//         imageName = ""
//         pageCount = 1
//         currentPage = 0
//         pendingPage = 0
//         pageCounter.isHidden = true
//         likeHeart.alpha = 0
//     }
//
//     func showLikeHeart() {
//         likeHeart.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
//         likeHeart.alpha = 0
//         UIView.animate(withDuration: 0.15, animations: {
//             self.likeHeart.alpha = 1
//             self.likeHeart.transform = .identity
//         }, completion: { _ in
//             UIView.animate(withDuration: 0.25, delay: 0.35, options: [], animations: {
//                 self.likeHeart.alpha = 0
//             })
//         })
//     }
//
//     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//         return pageCount
//     }
//
//     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DesignPostMediaPageCell", for: indexPath) as! DesignPostMediaPageCell
//         cell.configure(imageName: imageName)
//         return cell
//     }
//
//     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//         updatePage(from: scrollView)
//     }
//
//     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//         if !decelerate {
//             updatePage(from: scrollView)
//         }
//     }
//
//     private func updatePage(from scrollView: UIScrollView) {
//         let width = max(scrollView.bounds.width, 1)
//         let page = min(max(Int(round(scrollView.contentOffset.x / width)), 0), pageCount - 1)
//         currentPage = page
//         pendingPage = page
//         pageCounter.text = "  \(page + 1)/\(pageCount)  "
//         onPageChange?(page)
//     }
//
//     @objc private func doubleTapped() {
//         onDoubleTap?()
//     }
// }
//
//
// private final class DesignPostMediaPageCell: UICollectionViewCell {
//
//     private let imageView = UIImageView()
//
//     override init(frame: CGRect) {
//         super.init(frame: frame)
//         imageView.contentMode = .scaleAspectFill
//         imageView.clipsToBounds = true
//         imageView.translatesAutoresizingMaskIntoConstraints = false
//         contentView.addSubview(imageView)
//         NSLayoutConstraint.activate([
//             imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//             imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//             imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//         ])
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//
//     func configure(imageName: String) {
//         imageView.image = UIImage(named: imageName)
//     }
//
//     override func prepareForReuse() {
//         super.prepareForReuse()
//         imageView.image = nil
//     }
// }
//
//
// private final class DesignPostActions: UIView {
//
//     var onLike: (() -> Void)?
//     var onSave: (() -> Void)?
//
//     private let likeButton = UIButton(type: .system)
//     private let commentButton = UIButton(type: .system)
//     private let shareButton = UIButton(type: .system)
//     private let saveButton = UIButton(type: .system)
//     private let leftStack = UIStackView()
//     private let dotsStack = UIStackView()
//     private var pageCount = 1
//     private var page = 0
//
//     override init(frame: CGRect) {
//         super.init(frame: frame)
//         backgroundColor = DesignStyleTemp.background
//
//         configureIconButton(likeButton, name: "heart")
//         configureIconButton(commentButton, name: "bubble.right")
//         configureIconButton(shareButton, name: "paperplane")
//         configureIconButton(saveButton, name: "bookmark")
//         likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
//         saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
//
//         leftStack.axis = .horizontal
//         leftStack.spacing = DesignStyleTemp.actionGap
//         leftStack.alignment = .center
//         leftStack.addArrangedSubview(likeButton)
//         leftStack.addArrangedSubview(commentButton)
//         leftStack.addArrangedSubview(shareButton)
//
//         dotsStack.axis = .horizontal
//         dotsStack.spacing = DesignStyleTemp.dotSpacing
//         dotsStack.alignment = .center
//
//         [leftStack, dotsStack, saveButton].forEach {
//             $0.translatesAutoresizingMaskIntoConstraints = false
//             addSubview($0)
//         }
//
//         NSLayoutConstraint.activate([
//             leftStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DesignStyleTemp.actionLeading),
//             leftStack.centerYAnchor.constraint(equalTo: centerYAnchor),
//
//             likeButton.widthAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
//             likeButton.heightAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
//             commentButton.widthAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
//             commentButton.heightAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
//             shareButton.widthAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
//             shareButton.heightAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
//
//             dotsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
//             dotsStack.centerYAnchor.constraint(equalTo: centerYAnchor),
//
//             saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DesignStyleTemp.actionLeading),
//             saveButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//             saveButton.widthAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
//             saveButton.heightAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget)
//         ])
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//
//     func configure(pageCount: Int, page: Int, liked: Bool, saved: Bool) {
//         self.pageCount = pageCount
//         self.page = page
//         setLiked(liked, animated: false)
//         setSaved(saved)
//         rebuildDots()
//     }
//
//     func setPage(_ page: Int, count: Int) {
//         self.page = page
//         pageCount = count
//         rebuildDots()
//     }
//
//     func setLiked(_ liked: Bool, animated: Bool) {
//         let name = liked ? "heart.fill" : "heart"
//         likeButton.setImage(DesignStyleTemp.outlineIcon(name), for: .normal)
//         likeButton.tintColor = liked ? DesignStyleTemp.liked : DesignStyleTemp.primaryText
//         if animated {
//             likeButton.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
//             UIView.animate(withDuration: 0.15) {
//                 self.likeButton.transform = .identity
//             }
//         }
//     }
//
//     func setSaved(_ saved: Bool) {
//         let name = saved ? "bookmark.fill" : "bookmark"
//         saveButton.setImage(DesignStyleTemp.outlineIcon(name), for: .normal)
//         saveButton.tintColor = DesignStyleTemp.primaryText
//     }
//
//     func prepareForReuse() {
//         dotsStack.arrangedSubviews.forEach {
//             dotsStack.removeArrangedSubview($0)
//             $0.removeFromSuperview()
//         }
//         setLiked(false, animated: false)
//         setSaved(false)
//     }
//
//     private func configureIconButton(_ button: UIButton, name: String) {
//         button.setImage(DesignStyleTemp.outlineIcon(name), for: .normal)
//         button.tintColor = DesignStyleTemp.primaryText
//     }
//
//     private func rebuildDots() {
//         dotsStack.arrangedSubviews.forEach {
//             dotsStack.removeArrangedSubview($0)
//             $0.removeFromSuperview()
//         }
//         guard pageCount > 1 else {
//             dotsStack.isHidden = true
//             return
//         }
//         dotsStack.isHidden = false
//         let visible = min(pageCount, DesignStyleTemp.maxDots)
//         let activeIndex: Int
//         if pageCount <= DesignStyleTemp.maxDots {
//             activeIndex = page
//         } else {
//             activeIndex = min(page * (visible - 1) / max(pageCount - 1, 1), visible - 1)
//         }
//         for index in 0..<visible {
//             let dot = UIView()
//             dot.backgroundColor = index == activeIndex ? DesignStyleTemp.activePage : DesignStyleTemp.inactivePage
//             dot.layer.cornerRadius = DesignStyleTemp.dotSize / 2
//             dot.translatesAutoresizingMaskIntoConstraints = false
//             dot.widthAnchor.constraint(equalToConstant: DesignStyleTemp.dotSize).isActive = true
//             dot.heightAnchor.constraint(equalToConstant: DesignStyleTemp.dotSize).isActive = true
//             dotsStack.addArrangedSubview(dot)
//         }
//     }
//
//     @objc private func likeTapped() {
//         onLike?()
//     }
//
//     @objc private func saveTapped() {
//         onSave?()
//     }
// }

// STYLE: DesignStyleTemp
// Source: Style/DesignStyleTemp.swift
//
// //
// //  DesignStyleTemp.swift
// //  Kite
// //
// //  Temporary style for the Instagram-style design post.
// //  Does not replace Colors, Fonts, or Layout.
// //
//
// import UIKit
//
//
// enum DesignStyleTemp {
//
//     //COLORS
//     static let background = UIColor.white
//     static let primaryText = UIColor.black
//     static let secondaryText = UIColor(red: 0.47, green: 0.47, blue: 0.47, alpha: 1)
//     static let divider = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
//     static let activePage = UIColor(red: 0.0, green: 0.62, blue: 0.95, alpha: 1)
//     static let inactivePage = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
//     static let liked = UIColor(red: 1.0, green: 0.19, blue: 0.25, alpha: 1)
//     static let pageCounterBackground = UIColor.black.withAlphaComponent(0.55)
//
//     //FONTS
//     static let usernameFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
//     static let likeCountFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
//     static let captionFont = UIFont.systemFont(ofSize: 15, weight: .regular)
//     static let moreFont = UIFont.systemFont(ofSize: 15, weight: .regular)
//     static let dateFont = UIFont.systemFont(ofSize: 13, weight: .regular)
//     static let pageCounterFont = UIFont.systemFont(ofSize: 13, weight: .medium)
//     static let audioFont = UIFont.systemFont(ofSize: 13, weight: .regular)
//
//     //LAYOUT
//     static let headerHeight: CGFloat = 68
//     static let headerLeading: CGFloat = 12
//     static let headerTrailing: CGFloat = 8
//     static let avatarSize: CGFloat = 42
//     static let avatarToUsername: CGFloat = 8
//     static let touchTarget: CGFloat = 44
//     static let mediaAspect: CGFloat = 1.5
//     static let actionsHeight: CGFloat = 48
//     static let iconPointSize: CGFloat = 26
//     static let actionLeading: CGFloat = 8
//     static let actionGap: CGFloat = 2
//     static let textInset: CGFloat = 16
//     static let likesTop: CGFloat = 2
//     static let captionTop: CGFloat = 2
//     static let dateTop: CGFloat = 6
//     static let postBottom: CGFloat = 28
//     static let pageCounterTop: CGFloat = 14
//     static let pageCounterTrailing: CGFloat = 14
//     static let pageCounterHeight: CGFloat = 28
//     static let pageCounterPadding: CGFloat = 10
//     static let dotSize: CGFloat = 6
//     static let dotSpacing: CGFloat = 5
//     static let captionLineSpacing: CGFloat = 2
//     static let maxCaptionLines = 3
//     static let maxDots = 5
//
//     static func outlineIcon(_ name: String) -> UIImage? {
//         let configuration = UIImage.SymbolConfiguration(pointSize: iconPointSize, weight: .regular)
//         return UIImage(systemName: name, withConfiguration: configuration)
//     }
// }

// =============================================================================
// HEADER: IndividualPostViewController
// Live cells: PostCell (row 0), CommentCell (each comment)
// Style: Colors, Fonts, ImageStyle (listed under each cell)
// PostCell is built from PostHeader, PostImage, PostCaption, PostSocials, MainDivider
// =============================================================================
//
// CODE
// Source: App/Main/Post/IndividualPostViewController.swift
//
// func setupIndividualPostTableView() {
//     individualPostTableView.dataSource = self
//     individualPostTableView.delegate = self
//     individualPostTableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
//     individualPostTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
//     individualPostTableView.rowHeight = UITableView.automaticDimension
//     individualPostTableView.separatorStyle = .none
//     individualPostTableView.backgroundColor = Colors.feedBackground
// }
//
// func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//     return 1 + comments.count
// }
//
// func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//     if indexPath.row == 0 {
//         let postCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
//         postCell.configure(postID: postID)
//         return postCell
//     } else {
//         let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
//         let comment = comments[indexPath.row - 1]
//         commentCell.configureCommentCell(with: comment)
//         return commentCell
//     }
// }
//
// func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//     return UITableView.automaticDimension
// }
//
// STYLE used by PostCell
// Colors.feedBackground
// PostHeader: Fonts.postHeaderEventTitleFont, Fonts.postHeaderEventTimeFont
//             Colors.postHeaderEventTitleTextColor, Colors.postHeaderEventTimeTextColor
// PostImage: ImageStyle.postImage
// PostCaption: ImageStyle.userProfileImage diameter 38
//              Fonts.postUsernameFont, Fonts.postedAtFont, Fonts.postCaptionFont
//              Colors.screenBackground, Colors.primaryGrayText, Colors.postedAtTextColor, Colors.postCaptionFontColor
//
// STYLE used by CommentCell
// Colors.screenBackground
// ImageStyle.userProfileImage diameter 38
// Fonts.postUsernameFont, Fonts.postedAtFont, Fonts.postCaptionFont, Fonts.regular14
// Colors.primaryGrayText, Colors.postedAtTextColor, Colors.postCaptionFontColor
//
// CELL: PostCell
// Source: App/Main/Post/Cells/PostCell.swift
//
// //
// //  PostCell.swift
// //  Kite
// //
// //  Created by David Vasquez on 2/22/26.
// //
//
// import UIKit
//
// //LOGIC
// //UI COMPONENTS
// //MANAGE VIEWS
// //LAYOUT and UI
// //ACTIONS
// //FUNCTIONS
//
// final class PostCell: UITableViewCell {
//
//     //UI COMPONENTS
//
//     //Kite
//     private let postHeader = PostHeader()
//     private let postImage = PostImage()
//     private let postCaption = PostCaption()
//     private let postSocials = PostSocials()
//     private let mainDivider = MainDivider()
//
//     //Wishlist
//     //private let itemDivider = ItemDivider()
//     //private let itemHeader = ItemHeader()
//     //private let itemBody = ItemBody()
//     //private let postSocials = PostSocials()
//
//
//     //MANAGE VIEWS
//     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//         super.init(style: style, reuseIdentifier: reuseIdentifier)
//         selectionStyle = .none
//         backgroundColor = Colors.feedBackground
//         contentView.backgroundColor = .clear
//         //Kite
//         setupPost()
//
//         //Wishlist
//         //setupItem()
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//
//     //Kite
//     private func setupPost() {
//         [postHeader, postImage, postCaption, postSocials, mainDivider].forEach {
//             $0.translatesAutoresizingMaskIntoConstraints = false
//             contentView.addSubview($0)
//         }
//         NSLayoutConstraint.activate([
//             postHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
//             postHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             postHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//             postImage.topAnchor.constraint(equalTo: postHeader.bottomAnchor),
//             postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//             postCaption.topAnchor.constraint(equalTo: postImage.bottomAnchor),
//             postCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             postCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//             postSocials.topAnchor.constraint(equalTo: postCaption.bottomAnchor),
//             postSocials.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             postSocials.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//             mainDivider.topAnchor.constraint(equalTo: postSocials.bottomAnchor),
//             mainDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             mainDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//             mainDivider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//         ])
//     }
//
//     //Wishlist
//     // Post-level separation only — internal item components stay unaware of feed spacing.
//     /*
//     private func setupItem() {
//         itemDivider.install(in: contentView)
//
//         [itemHeader, itemBody, postSocials].forEach {
//             $0.translatesAutoresizingMaskIntoConstraints = false
//             contentView.addSubview($0)
//         }
//
//         NSLayoutConstraint.activate([
//             itemHeader.topAnchor.constraint(equalTo: itemDivider.contentTopAnchor),
//             itemHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             itemHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//
//             itemBody.topAnchor.constraint(equalTo: itemHeader.bottomAnchor),
//             itemBody.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             itemBody.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//
//             postSocials.topAnchor.constraint(equalTo: itemBody.bottomAnchor),
//             postSocials.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             postSocials.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//         ])
//
//         itemDivider.linkContentBottom(to: postSocials.bottomAnchor)
//
//         itemBody.onPurchaseTapped = { [weak self] post, state in
//             self?.handlePurchaseAction(post: post, state: state)
//         }
//     }
//     */
//
//     //ACTIONS
//     private func handlePurchaseAction(post: Post, state: PurchaseButtonState) {
//         guard let presentingVC = findViewController() else { return }
//
//         switch state {
//         case .hidden:
//             break
//
//         case .purchase:
//             let storyboard = UIStoryboard(name: "Post", bundle: nil)
//             guard let itemPurchaseVC = storyboard.instantiateViewController(withIdentifier: "ItemPurchaseViewControllerID") as? ItemPurchaseViewController else { return }
//             itemPurchaseVC.post = post
//             itemPurchaseVC.groupID = post.groupID
//             itemPurchaseVC.modalPresentationStyle = .pageSheet
//             presentingVC.present(itemPurchaseVC, animated: true)
//
//         case .youPurchased:
//             let alert = UIAlertController(
//                 title: nil,
//                 message: "Cancel this purchase?",
//                 preferredStyle: .actionSheet
//             )
//             alert.addAction(UIAlertAction(title: "Cancel Purchase", style: .destructive) { _ in
//                 let groupID = post.groupID ?? 0
//                 Task {
//                     await PostLogic.shared.removeItem(post: post, groupID: groupID)
//                 }
//             })
//             alert.addAction(UIAlertAction(title: "Keep", style: .cancel))
//             if let popover = alert.popoverPresentationController {
//                 popover.sourceView = self
//                 popover.sourceRect = bounds
//             }
//             presentingVC.present(alert, animated: true)
//
//         case .purchased(let by):
//             let alert = UIAlertController(
//                 title: nil,
//                 message: "\(by) purchased this item already.",
//                 preferredStyle: .alert
//             )
//             alert.addAction(UIAlertAction(title: "OK", style: .default))
//             presentingVC.present(alert, animated: true)
//         }
//     }
//
//     private func findViewController() -> UIViewController? {
//         var responder: UIResponder? = self
//         while responder != nil {
//             responder = responder?.next
//             if let vc = responder as? UIViewController { return vc }
//         }
//         return nil
//     }
//
//     //Configure socials with post so like count (and later like action) use live data.
//     func configure(postID: Int) {
//         postSocials.configure(postID: postID)
//         if let post = PostDataController.shared.getPostByID(postID: postID) {
//             //Kite
//             postHeader.configure(with: post)
//             postImage.configure(with: post)
//             postCaption.configure(with: post)
//             //Wishlist
//             //itemHeader.configure(with: post)
//             //itemBody.configure(with: post)
//         }
//     }
//
//     func updatePost(with post: Post) {
//         //Kite
//         postHeader.configure(with: post)
//         postImage.configure(with: post)
//         postCaption.configure(with: post)
//         postSocials.configure(postID: post.postID)
//         //Wishlist
//         //itemHeader.configure(with: post)
//         //itemBody.configure(with: post)
//         //postSocials.configure(postID: post.postID)
//     }
//
//     func updateItem(with post: Post) {
//         //Kite
//         postHeader.configure(with: post)
//         postImage.configure(with: post)
//         postCaption.configure(with: post)
//         postSocials.configure(postID: post.postID)
//         //Wishlist
//         //itemHeader.configure(with: post)
//         //itemBody.configure(with: post)
//         //postSocials.configure(postID: post.postID)
//     }
// }
//
//
//
//
//
// /*
// final class PostCell: UITableViewCell {
//
//     
//     
//     //LOGIC
//     private let postDataController = PostDataController.shared
//     private var postID: Int?
//
//     //UI COMPONENTS
//     private let layout = ItemCellLayout()
//     //Post will include
//     //Socials
//     //Caption
//     //Comments will not be here but will be pulled in
//
//     //MANAGE VIEWS
//     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//         super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//         contentView.addSubview(layout)
//         layout.translatesAutoresizingMaskIntoConstraints = false
//
//
//     override func prepareForReuse() {
//         super.prepareForReuse()
//         postID = nil
//         layout.resetImageLayout()
//     }
//
//     deinit {
//         NotificationCenter.default.removeObserver(self)
//     }
//
//     //ACTIONS
//     func configurePostCell(postID: Int) {
//         self.postID = postID
//         refreshPostCellUI()
//     }
//
//     //FUNCTIONS
//     @objc private func purchaseTapped() {
//         print("purchase")
//     }
//
//     @objc private func likeTapped() {
//         guard
//             let postID,
//             let post = postDataController.getPostByID(postID: postID)
//         else { return }
//
//         let groupID = post.groupID ?? 0
//         Task { await PostLogic.shared.toggleLike(post: post, groupID: groupID) }
//     }
//
//     private func refreshPostCellUI() {
//         guard
//             let postID,
//             let post = postDataController.getPostByID(postID: postID)
//         else { return }
//
//         layout.apply(post: post)
//     }
//
//     @objc private func handlePostUpdated(_ notification: Notification) {
//         guard
//             let updatedPostID = notification.object as? Int,
//             updatedPostID == postID
//         else { return }
//
//         refreshPostCellUI()
//     }
//      
//      
//         NSLayoutConstraint.activate([
//             layout.topAnchor.constraint(equalTo: contentView.topAnchor),
//             layout.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             layout.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//             layout.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//         ])
//
//    
//         NotificationCenter.default.addObserver(
//             self,
//             selector: #selector(handlePostUpdated),
//             name: .postUpdated,
//             object: nil
//         )
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
// }
// */

// CELL: PostHeader
// Source: App/Main/Post/Components/Post/PostHeader.swift
//
// //
// //  PostHeader.swift
// //  Kite
// //
// //  Created by David Vasquez on 7/18/26.
// //
//
// import UIKit
//
// //LOGIC
// //UI COMPONENTS
// //MANAGE VIEWS
// //LAYOUT and UI
// //ACTIONS
// //FUNCTIONS
//
// final class PostHeader: UIView {
//
//     //UI COMPONENTS
//     let headerGroupImageView = UIView()
//     let headerGroupImage = UIImageView()
//
//     let headerGroupNameView = UIView()
//     let headerGroupNameLabel = UILabel()
//
//     let headerGroupInfoView = UIView()
//     let headerGroupInfoLabel = UILabel()
//
//     let headerGroupMenuView = UIView()
//     let headerGroupMenuIcon = UIImageView()
//     private let headerTextStackView = UIStackView()
//
//     //MANAGE VIEWS
//     override init(frame: CGRect) {
//         super.init(frame: frame)
//         setupViews()
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//
//     private func setupViews() {
//         backgroundColor = .clear
//         setupHeaderViews()
//     }
//
//     private func setupHeaderViews() {
//         headerGroupImageView.translatesAutoresizingMaskIntoConstraints = false
//         headerGroupImage.translatesAutoresizingMaskIntoConstraints = false
//         headerGroupNameView.translatesAutoresizingMaskIntoConstraints = false
//         headerGroupNameLabel.translatesAutoresizingMaskIntoConstraints = false
//         headerGroupInfoView.translatesAutoresizingMaskIntoConstraints = false
//         headerGroupInfoLabel.translatesAutoresizingMaskIntoConstraints = false
//         headerGroupMenuView.translatesAutoresizingMaskIntoConstraints = false
//         headerGroupMenuIcon.translatesAutoresizingMaskIntoConstraints = false
//         headerTextStackView.translatesAutoresizingMaskIntoConstraints = false
//
//         headerGroupImageView.backgroundColor = .clear
//         headerGroupNameView.backgroundColor = .clear
//         headerGroupInfoView.backgroundColor = .clear
//         headerGroupMenuView.backgroundColor = .clear
//
//         headerTextStackView.axis = .vertical
//         headerTextStackView.spacing = 2
//         headerTextStackView.alignment = .fill
//         headerTextStackView.distribution = .fill
//
//         headerGroupImage.contentMode = .scaleAspectFill
//         headerGroupImage.clipsToBounds = true
//         headerGroupImage.layer.cornerRadius = 4
//
//         headerGroupNameLabel.font = Fonts.postHeaderEventTitleFont
//         headerGroupNameLabel.textColor = Colors.postHeaderEventTitleTextColor
//         headerGroupNameLabel.numberOfLines = 1
//         headerGroupNameLabel.lineBreakMode = .byTruncatingTail
//
//         headerGroupInfoLabel.font = Fonts.postHeaderEventTimeFont
//         headerGroupInfoLabel.textColor = Colors.postHeaderEventTimeTextColor
//         headerGroupInfoLabel.numberOfLines = 1
//         headerGroupInfoLabel.lineBreakMode = .byTruncatingTail
//
//         headerGroupMenuIcon.image = UIImage(named: "menu-horizontal")
//         headerGroupMenuIcon.contentMode = .scaleAspectFit
//
//         addSubview(headerGroupImageView)
//         headerGroupImageView.addSubview(headerGroupImage)
//         addSubview(headerTextStackView)
//         headerTextStackView.addArrangedSubview(headerGroupNameView)
//         headerGroupNameView.addSubview(headerGroupNameLabel)
//         headerTextStackView.addArrangedSubview(headerGroupInfoView)
//         headerGroupInfoView.addSubview(headerGroupInfoLabel)
//         addSubview(headerGroupMenuView)
//         headerGroupMenuView.addSubview(headerGroupMenuIcon)
//
//         NSLayoutConstraint.activate([
//             heightAnchor.constraint(equalToConstant: 52),
//
//             headerGroupImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//             headerGroupImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//             headerGroupImageView.widthAnchor.constraint(equalToConstant: 40),
//             headerGroupImageView.heightAnchor.constraint(equalToConstant: 40),
//
//             headerGroupImage.topAnchor.constraint(equalTo: headerGroupImageView.topAnchor),
//             headerGroupImage.leadingAnchor.constraint(equalTo: headerGroupImageView.leadingAnchor),
//             headerGroupImage.trailingAnchor.constraint(equalTo: headerGroupImageView.trailingAnchor),
//             headerGroupImage.bottomAnchor.constraint(equalTo: headerGroupImageView.bottomAnchor),
//
//             headerTextStackView.leadingAnchor.constraint(equalTo: headerGroupImageView.trailingAnchor, constant: 10),
//             headerTextStackView.trailingAnchor.constraint(equalTo: headerGroupMenuView.leadingAnchor, constant: -10),
//             headerTextStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
//
//             headerGroupNameLabel.topAnchor.constraint(equalTo: headerGroupNameView.topAnchor),
//             headerGroupNameLabel.leadingAnchor.constraint(equalTo: headerGroupNameView.leadingAnchor),
//             headerGroupNameLabel.trailingAnchor.constraint(equalTo: headerGroupNameView.trailingAnchor),
//             headerGroupNameLabel.bottomAnchor.constraint(equalTo: headerGroupNameView.bottomAnchor),
//
//             headerGroupInfoLabel.topAnchor.constraint(equalTo: headerGroupInfoView.topAnchor),
//             headerGroupInfoLabel.leadingAnchor.constraint(equalTo: headerGroupInfoView.leadingAnchor),
//             headerGroupInfoLabel.trailingAnchor.constraint(equalTo: headerGroupInfoView.trailingAnchor),
//             headerGroupInfoLabel.bottomAnchor.constraint(equalTo: headerGroupInfoView.bottomAnchor),
//
//             headerGroupMenuView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//             headerGroupMenuView.centerYAnchor.constraint(equalTo: centerYAnchor),
//             headerGroupMenuView.widthAnchor.constraint(equalToConstant: 50),
//             headerGroupMenuView.heightAnchor.constraint(equalToConstant: 50),
//
//             headerGroupMenuIcon.centerXAnchor.constraint(equalTo: headerGroupMenuView.centerXAnchor),
//             headerGroupMenuIcon.centerYAnchor.constraint(equalTo: headerGroupMenuView.centerYAnchor),
//             headerGroupMenuIcon.widthAnchor.constraint(equalToConstant: 24),
//             headerGroupMenuIcon.heightAnchor.constraint(equalToConstant: 24)
//         ])
//     }
//
//     //FUNCTIONS
//     func configure(with post: Post) {
//         let groupImage = post.groupImageData ?? UIImage(named: "background_1") ?? UIImage()
//         headerGroupImage.image = groupImage
//
//         headerGroupNameLabel.text = post.groupName ?? "Unknown Group"
//         headerGroupInfoLabel.text = post.timeMessage ?? "Just now"
//     }
// }

// CELL: PostImage
// Source: App/Main/Post/Components/Post/PostImage.swift
//
// //
// //  PostImage.swift
// //  Kite
// //
// //  Created by David Vasquez on 7/18/26.
// //
//
// import UIKit
//
// //LOGIC
// //UI COMPONENTS
// //MANAGE VIEWS
// //LAYOUT and UI
// //ACTIONS
// //FUNCTIONS
//
// final class PostImage: UIView {
//
//     //UI COMPONENTS
//     let postImageView = UIImageView()
//     private var imageAspectRatioConstraint: NSLayoutConstraint?
//     private var imageZeroHeightConstraint: NSLayoutConstraint?
//
//     //MANAGE VIEWS
//     override init(frame: CGRect) {
//         super.init(frame: frame)
//         setupViews()
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//
//     private func setupViews() {
//         backgroundColor = .clear
//         setupImageView()
//     }
//
//     private func setupImageView() {
//         ImageStyle.postImage(imageView: postImageView)
//
//         addSubview(postImageView)
//         postImageView.translatesAutoresizingMaskIntoConstraints = false
//
//         NSLayoutConstraint.activate([
//             postImageView.topAnchor.constraint(equalTo: topAnchor),
//             postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//             postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//             postImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
//         ])
//
//         updatePostImage(nil)
//     }
//
//     //FUNCTIONS
//     func configure(with post: Post) {
//         updatePostImage(post.postImageData)
//     }
//
//     private func updatePostImage(_ image: UIImage?) {
//         imageAspectRatioConstraint?.isActive = false
//         imageZeroHeightConstraint?.isActive = false
//
//         guard let image, image.size.width > 0 else {
//             postImageView.image = nil
//             imageZeroHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 0)
//             imageZeroHeightConstraint?.isActive = true
//             return
//         }
//
//         postImageView.image = image
//         let aspectRatio = image.size.height / image.size.width
//         imageAspectRatioConstraint = postImageView.heightAnchor.constraint(
//             equalTo: postImageView.widthAnchor,
//             multiplier: aspectRatio
//         )
//         imageAspectRatioConstraint?.isActive = true
//     }
// }

// CELL: PostCaption
// Source: App/Main/Post/Components/Post/PostCaption.swift
//
// //
// //  PostCaption.swift
// //  Kite
// //
// //  Created by David Vasquez on 2/22/26.
// //
//
// import UIKit
//
//
// //LOGIC
// //UI COMPONENTS
// //MANAGE VIEWS
// //LAYOUT and UI
// //ACTIONS
// //FUNCTIONS
//
//
// // PostCaption is a UI renderer. It displays post caption info. It does NOT decide when or how the table refreshes.
// // The ViewController reacts to data changes via NotificationCenter.
//
// final class PostCaption: UIView {
//
//     //LOGIC
//     private var usersDataController: UsersDataController { UsersDataController.shared }
//     private var loadUserName: String?
//
//     //UI COMPONENTS
//     //Left: User Image
//     let userImageArea = UIView()
//     let userProfileImageView = UIImageView()
//
//     //Right Column
//     let commentHeaderView = UIView()
//     let userNameLabel = UILabel()
//     let postedAtLabel = UILabel()
//     let commentBodyView = UIView()
//     let commentFooterView = UIView()
//
//     //Body: expanding comment text (placeholder for now)
//     private let commentBodyLabel = UILabel()
//
//     //MANAGE VIEWS
//     override init(frame: CGRect) {
//         super.init(frame: frame)
//         setupViews()
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//
//     private func setupViews() {
//         setupUserImageArea()
//         setupCommentHeaderView()
//         setupCommentBodyView()
//         setupCommentFooterView()
//     }
//
//     //LEFT: User Image Area
//     private func setupUserImageArea() {
//         userImageArea.backgroundColor = Colors.screenBackground
//
//         userProfileImageView.image = UIImage(named: "background_1")
//         ImageStyle.userProfileImage(imageView: userProfileImageView, diameter: 38)
//         userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
//
//         addSubview(userImageArea)
//         userImageArea.translatesAutoresizingMaskIntoConstraints = false
//         userImageArea.addSubview(userProfileImageView)
//
//         NSLayoutConstraint.activate([
//             userImageArea.leadingAnchor.constraint(equalTo: leadingAnchor),
//             userImageArea.topAnchor.constraint(equalTo: topAnchor),
//             userImageArea.bottomAnchor.constraint(equalTo: bottomAnchor),
//             userImageArea.widthAnchor.constraint(equalToConstant: 46),
//
//             userProfileImageView.topAnchor.constraint(equalTo: userImageArea.topAnchor, constant: 6),
//             userProfileImageView.leadingAnchor.constraint(equalTo: userImageArea.leadingAnchor, constant: 4),
//             userProfileImageView.trailingAnchor.constraint(equalTo: userImageArea.trailingAnchor, constant: -4),
//             userProfileImageView.widthAnchor.constraint(equalToConstant: 38),
//             userProfileImageView.heightAnchor.constraint(equalToConstant: 38)
//         ])
//     }
//
//     //RIGHT: Comment Header — [username] [time ago] on one row, left aligned (Instagram-style)
//     private func setupCommentHeaderView() {
//         commentHeaderView.backgroundColor = UIColor(red: 1.0, green: 0.82, blue: 0.80, alpha: 1.0)
//
//         userNameLabel.font = Fonts.postUsernameFont
//         userNameLabel.textColor = Colors.primaryGrayText
//         userNameLabel.numberOfLines = 1
//         userNameLabel.lineBreakMode = .byTruncatingTail
//
//         postedAtLabel.font = Fonts.postedAtFont
//         postedAtLabel.textColor = Colors.postedAtTextColor
//         postedAtLabel.numberOfLines = 1
//         postedAtLabel.lineBreakMode = .byTruncatingTail
//
//         userNameLabel.setContentHuggingPriority(.required, for: .horizontal)
//         userNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//
//         postedAtLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//         postedAtLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//
//         addSubview(commentHeaderView)
//         commentHeaderView.translatesAutoresizingMaskIntoConstraints = false
//         userNameLabel.translatesAutoresizingMaskIntoConstraints = false
//         postedAtLabel.translatesAutoresizingMaskIntoConstraints = false
//
//         commentHeaderView.addSubview(userNameLabel)
//         commentHeaderView.addSubview(postedAtLabel)
//
//         NSLayoutConstraint.activate([
//             commentHeaderView.topAnchor.constraint(equalTo: topAnchor),
//             commentHeaderView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
//             commentHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor),
//             commentHeaderView.heightAnchor.constraint(equalToConstant: 22),
//
//             userNameLabel.leadingAnchor.constraint(equalTo: commentHeaderView.leadingAnchor),
//             userNameLabel.centerYAnchor.constraint(equalTo: commentHeaderView.centerYAnchor),
//
//             postedAtLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 4),
//             postedAtLabel.centerYAnchor.constraint(equalTo: commentHeaderView.centerYAnchor, constant: 1),
//             postedAtLabel.trailingAnchor.constraint(lessThanOrEqualTo: commentHeaderView.trailingAnchor)
//         ])
//     }
//
//     //RIGHT: Comment Body — height hugs post caption (dynamic, no min height)
//     private func setupCommentBodyView() {
//         commentBodyView.backgroundColor = UIColor(red: 0.86, green: 0.82, blue: 0.96, alpha: 1.0)
//
//         commentBodyLabel.font = Fonts.postCaptionFont
//         commentBodyLabel.textColor = Colors.postCaptionFontColor
//         commentBodyLabel.numberOfLines = 0
//         commentBodyLabel.text = "body"
//
//         commentBodyLabel.setContentHuggingPriority(.required, for: .vertical)
//         commentBodyLabel.setContentCompressionResistancePriority(.required, for: .vertical)
//
//         addSubview(commentBodyView)
//         commentBodyView.translatesAutoresizingMaskIntoConstraints = false
//         commentBodyLabel.translatesAutoresizingMaskIntoConstraints = false
//         commentBodyView.addSubview(commentBodyLabel)
//
//         NSLayoutConstraint.activate([
//             commentBodyView.topAnchor.constraint(equalTo: commentHeaderView.bottomAnchor),
//             commentBodyView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
//             commentBodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
//
//             commentBodyLabel.topAnchor.constraint(equalTo: commentBodyView.topAnchor),
//             commentBodyLabel.leadingAnchor.constraint(equalTo: commentBodyView.leadingAnchor),
//             commentBodyLabel.trailingAnchor.constraint(equalTo: commentBodyView.trailingAnchor),
//             commentBodyLabel.bottomAnchor.constraint(equalTo: commentBodyView.bottomAnchor)
//         ])
//     }
//
//     //RIGHT: Comment Footer
//     private func setupCommentFooterView() {
//         commentFooterView.backgroundColor = UIColor.systemGray5
//
//         addSubview(commentFooterView)
//         commentFooterView.translatesAutoresizingMaskIntoConstraints = false
//
//         NSLayoutConstraint.activate([
//             commentFooterView.topAnchor.constraint(equalTo: commentBodyView.bottomAnchor),
//             commentFooterView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
//             commentFooterView.trailingAnchor.constraint(equalTo: trailingAnchor),
//             commentFooterView.heightAnchor.constraint(equalToConstant: 2),
//             commentFooterView.bottomAnchor.constraint(equalTo: bottomAnchor)
//         ])
//     }
//
//     //FUNCTIONS
//     func configure(with post: Post) {
//         let postID = post.postID
//         let postCaption = post.postCaption ?? "no caption"
//
//         print("PostCaption: postID=\(postID) caption=\(postCaption)")
//
//         commentBodyLabel.text = postCaption
//         postedAtLabel.text = post.timeMessage ?? "now"
//
//         guard let username = post.postFrom, !username.isEmpty else {
//             userNameLabel.text = nil
//             print("PostCaption: missing postFrom for postID \(postID)")
//             return
//         }
//
//         userNameLabel.text = username
//         print("PostCaption: userName=\(username)")
//         loadUserProfile(username: username)
//     }
//
//     private func loadUserProfile(username: String) {
//         loadUserName = username
//
//         Task {
//             guard let user = await usersDataController.getOrFetchUserWithImage(username: username) else {
//                 print("PostCaption: failed to load user \(username)")
//                 return
//             }
//
//             guard loadUserName == username else { return }
//
//             print("PostCaption: userName=\(user.userName) userImage=\(user.userImage)")
//
//             await MainActor.run {
//                 guard self.loadUserName == username else { return }
//                 if let image = user.profileImage {
//                     self.userProfileImageView.image = image
//                 }
//             }
//         }
//     }
//
//     //TEMP
//     private func addTempLabel(_ text: String, to view: UIView) {
//         let label = UILabel()
//         label.text = text
//         label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
//         label.textColor = Colors.primaryGrayText
//         label.numberOfLines = 0
//         label.textAlignment = .center
//         label.translatesAutoresizingMaskIntoConstraints = false
//         view.addSubview(label)
//
//         NSLayoutConstraint.activate([
//             label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//             label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//             label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 4),
//             label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -4)
//         ])
//     }
// }

// CELL: PostSocials
// Source: App/Main/Post/Components/Post/PostSocials.swift
//
// //
// //  PostSocials.swift
// //  Kite
// //
// //  Created by David Vasquez on 2/22/26.
// //
//
// import UIKit
//
//
//
// //LOGIC
// //UI COMPONENTS
// //MANAGE VIEWS
// //LAYOUT and UI
// //ACTIONS
// //FUNCTIONS
//
// final class PostSocials: UIView {
//     
//     
//     //LOGIC
//     private let postDataController = PostDataController.shared
//     private let spinnerHelper = SpinnerHelper()
//     private var postID: Int?
//
//     //UI COMPONENTS
//     let postLikesView = UIView()
//     let postCommentView = UIView()
//     let postSharesView = UIView()
//
//     private let likesIconView = UIImageView()
//     private let likesIconBackground = UIView()
//     private let likesCountLabel = UILabel()
//     private let commentIconView = UIImageView()
//     private let commentIconBackground = UIView()
//     private let commentCountLabel = UILabel()
//     private let bookmarkIconView = UIImageView()
//     private let bookmarkIconBackground = UIView()
//     private let bookmarkCountLabel = UILabel()
//
//     private let stackView = UIStackView()
//     private let countMaxWidth: CGFloat = 60
//     private let iconSize: CGFloat = 24
//     private let iconBackgroundSize: CGFloat = 28
//
//     //MANAGE VIEWS
//     override init(frame: CGRect) {
//         //print("POST SOCIALS")
//         super.init(frame: frame)
//         setupViews()
//         NotificationCenter.default.addObserver(
//             self,
//             selector: #selector(handlePostUpdated(_:)),
//             name: .postUpdated,
//             object: nil
//         )
//         NotificationCenter.default.addObserver(
//             self,
//             selector: #selector(handlePostUpdated(_:)),
//             name: .commentUpdated,
//             object: nil
//         )
//     }
//
//     deinit {
//         NotificationCenter.default.removeObserver(self)
//     }
//     
//     
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//     
//     //LAYOUT and UI
//     private func setupViews() {
//         // backgroundColor = UIColor.systemPurple.withAlphaComponent(0.3)
//         translatesAutoresizingMaskIntoConstraints = false
//         NSLayoutConstraint.activate([
//             heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
//         ])
//
//         // postLikesView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.4)
//         // postCommentView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.4)
//         // postSharesView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.4)
//
//         stackView.axis = .horizontal
//         stackView.spacing = 8
//         stackView.alignment = .center
//         stackView.distribution = .fill
//         stackView.translatesAutoresizingMaskIntoConstraints = false
//         addSubview(stackView)
//
//         NSLayoutConstraint.activate([
//             stackView.topAnchor.constraint(equalTo: topAnchor),
//             stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
//             stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//             stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
//         ])
//
//         setupPostLikeViews()
//         setupPostCommentViews()
//         setupPostBookmarkViews()
//
//         stackView.addArrangedSubview(postLikesView)
//         stackView.addArrangedSubview(postCommentView)
//         stackView.addArrangedSubview(postSharesView)
//     }
//
//     private func setupPostLikeViews() {
//         postLikesView.isUserInteractionEnabled = true
//         let tap = UITapGestureRecognizer(target: self, action: #selector(handleLikeTapped))
//         postLikesView.addGestureRecognizer(tap)
//
//         likesIconBackground.backgroundColor = UIColor.tertiarySystemFill
//         likesIconBackground.layer.cornerRadius = iconBackgroundSize / 2
//         likesIconBackground.clipsToBounds = true
//
//         likesIconView.image = UIImage(named: "liked") ?? UIImage(systemName: "heart") 
//         likesIconView.contentMode = .scaleAspectFit
//         likesIconView.tintColor = .label
//
//         StyleOld.styleSocialCountText(likesCountLabel)
//         likesCountLabel.text = "1,815"
//         likesCountLabel.lineBreakMode = .byTruncatingTail
//
//         [postLikesView, likesIconBackground, likesIconView, likesCountLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
//         postLikesView.addSubview(likesIconBackground)
//         likesIconBackground.addSubview(likesIconView)
//         postLikesView.addSubview(likesCountLabel)
//
//         NSLayoutConstraint.activate([
//             postLikesView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
//             likesIconBackground.leadingAnchor.constraint(equalTo: postLikesView.leadingAnchor),
//             likesIconBackground.centerYAnchor.constraint(equalTo: postLikesView.centerYAnchor),
//             likesIconBackground.widthAnchor.constraint(equalToConstant: iconBackgroundSize),
//             likesIconBackground.heightAnchor.constraint(equalToConstant: iconBackgroundSize),
//             likesIconView.centerXAnchor.constraint(equalTo: likesIconBackground.centerXAnchor),
//             likesIconView.centerYAnchor.constraint(equalTo: likesIconBackground.centerYAnchor),
//             likesIconView.widthAnchor.constraint(equalToConstant: iconSize),
//             likesIconView.heightAnchor.constraint(equalToConstant: iconSize),
//             likesCountLabel.leadingAnchor.constraint(equalTo: likesIconBackground.trailingAnchor, constant: 4),
//             likesCountLabel.centerYAnchor.constraint(equalTo: postLikesView.centerYAnchor),
//             likesCountLabel.trailingAnchor.constraint(equalTo: postLikesView.trailingAnchor),
//             likesCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: countMaxWidth)
//         ])
//     }
//
//     private func setupPostCommentViews() {
//         commentIconBackground.backgroundColor = UIColor.tertiarySystemFill
//         commentIconBackground.layer.cornerRadius = iconBackgroundSize / 2
//         commentIconBackground.clipsToBounds = true
//
//         commentIconView.image = UIImage(named: "comment") ?? UIImage(systemName: "text.bubble")
//         commentIconView.contentMode = .scaleAspectFit
//         commentIconView.tintColor = .label
//
//         StyleOld.styleSocialCountText(commentCountLabel)
//         commentCountLabel.text = "15"
//         commentCountLabel.lineBreakMode = .byTruncatingTail
//
//         [postCommentView, commentIconBackground, commentIconView, commentCountLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
//         postCommentView.addSubview(commentIconBackground)
//         commentIconBackground.addSubview(commentIconView)
//         postCommentView.addSubview(commentCountLabel)
//
//         NSLayoutConstraint.activate([
//             postCommentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
//             commentIconBackground.leadingAnchor.constraint(equalTo: postCommentView.leadingAnchor),
//             commentIconBackground.centerYAnchor.constraint(equalTo: postCommentView.centerYAnchor),
//             commentIconBackground.widthAnchor.constraint(equalToConstant: iconBackgroundSize),
//             commentIconBackground.heightAnchor.constraint(equalToConstant: iconBackgroundSize),
//             commentIconView.centerXAnchor.constraint(equalTo: commentIconBackground.centerXAnchor),
//             commentIconView.centerYAnchor.constraint(equalTo: commentIconBackground.centerYAnchor),
//             commentIconView.widthAnchor.constraint(equalToConstant: iconSize),
//             commentIconView.heightAnchor.constraint(equalToConstant: iconSize),
//             commentCountLabel.leadingAnchor.constraint(equalTo: commentIconBackground.trailingAnchor, constant: 4),
//             commentCountLabel.centerYAnchor.constraint(equalTo: postCommentView.centerYAnchor),
//             commentCountLabel.trailingAnchor.constraint(equalTo: postCommentView.trailingAnchor),
//             commentCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: countMaxWidth)
//         ])
//     }
//
//     private func setupPostBookmarkViews() {
//         bookmarkIconBackground.backgroundColor = UIColor.tertiarySystemFill
//         bookmarkIconBackground.layer.cornerRadius = iconBackgroundSize / 2
//         bookmarkIconBackground.clipsToBounds = true
//
//         bookmarkIconView.image = UIImage(named: "bookmark") ?? UIImage(systemName: "bookmark")
//         bookmarkIconView.contentMode = .scaleAspectFit
//         bookmarkIconView.tintColor = .label
//
//         StyleOld.styleSocialCountText(bookmarkCountLabel)
//         bookmarkCountLabel.text = "4"
//         bookmarkCountLabel.lineBreakMode = .byTruncatingTail
//
//         [postSharesView, bookmarkIconBackground, bookmarkIconView, bookmarkCountLabel].forEach {
//             $0.translatesAutoresizingMaskIntoConstraints = false
//         }
//         postSharesView.addSubview(bookmarkIconBackground)
//         bookmarkIconBackground.addSubview(bookmarkIconView)
//         postSharesView.addSubview(bookmarkCountLabel)
//
//         NSLayoutConstraint.activate([
//             postSharesView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
//             bookmarkIconBackground.leadingAnchor.constraint(equalTo: postSharesView.leadingAnchor),
//             bookmarkIconBackground.centerYAnchor.constraint(equalTo: postSharesView.centerYAnchor),
//             bookmarkIconBackground.widthAnchor.constraint(equalToConstant: iconBackgroundSize),
//             bookmarkIconBackground.heightAnchor.constraint(equalToConstant: iconBackgroundSize),
//             bookmarkIconView.centerXAnchor.constraint(equalTo: bookmarkIconBackground.centerXAnchor),
//             bookmarkIconView.centerYAnchor.constraint(equalTo: bookmarkIconBackground.centerYAnchor),
//             bookmarkIconView.widthAnchor.constraint(equalToConstant: iconSize),
//             bookmarkIconView.heightAnchor.constraint(equalToConstant: iconSize),
//             bookmarkCountLabel.leadingAnchor.constraint(equalTo: bookmarkIconBackground.trailingAnchor, constant: 4),
//             bookmarkCountLabel.centerYAnchor.constraint(equalTo: postSharesView.centerYAnchor),
//             bookmarkCountLabel.trailingAnchor.constraint(equalTo: postSharesView.trailingAnchor),
//             bookmarkCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: countMaxWidth)
//         ])
//     }
//     
//     //ACTIONS
//     @objc private func handleLikeTapped() {
//         guard let postID,
//               let post = postDataController.getPostByID(postID: postID) else { return }
//         let groupID = post.groupID ?? 0
//
//         postLikesView.isUserInteractionEnabled = false
//         spinnerHelper.show(in: SpinnerHelper.keyWindow ?? self, delay: 0)
//
//         Task {
//             await PostLogic.shared.toggleLike(post: post, groupID: groupID)
//             await MainActor.run {
//                 spinnerHelper.hide()
//                 postLikesView.isUserInteractionEnabled = true
//             }
//         }
//     }
//
//     @objc private func handlePostUpdated(_ notification: Notification) {
//         guard let updatedPostID = notification.object as? Int,
//               updatedPostID == postID else { return }
//         refreshLikes()
//     }
//
//     
//     
//     //FUNCTIONS
//     //Configure with post so like area (icon + count) and later like action use live data.
//     func configure(postID: Int) {
//         self.postID = postID
//         refreshLikes()
//     }
//     
//     //Updates the like area and comment count from PostDataController.
//     private func refreshLikes() {
//         guard let postID else {
//             print("PostSocials: postID is nil, skipping refresh")
//             return
//         }
//         guard let post = postDataController.getPostByID(postID: postID) else {
//             print("PostSocials: post not found in PostDataController for postID \(postID)")
//             return
//         }
//         let likeCount = post.simpleLikesArray?.count ?? 0
//         let isLiked = post.isLikedByCurrentUser ?? false
//         let commentCount = post.commentsArray?.count ?? 0
//
//         likesIconView.image = isLiked
//             ? (UIImage(named: "liked") ?? UIImage(systemName: "heart.fill"))
//             : (UIImage(named: "like") ?? UIImage(systemName: "heart"))
//         likesCountLabel.text = "\(likeCount)"
//         commentCountLabel.text = "\(commentCount)"
//
//         //print("PostSocials: comment count = \(commentCount)")
//     }
//
//
// }
//
//
// /*
//  // Saved background colors (commented out in setupViews / setup*):
//  // self: systemPurple 0.3 | postLikesView: systemTeal 0.4 | postCommentView: systemOrange 0.4 | postSharesView: systemIndigo 0.4
//  // icon views: systemRed 0.5 | count labels: systemGreen 0.5
//
//  
//  group_messages
//  group_message_id
//  message
//  message_status sent, delivered, failed
//  created- time
//  recieved- time
//
//  group_users
//  message_app
//  message_phone
//  message_email
//
//  user_profile
//  email
//  phone
//
//  */
//
//
// /*
// private func setupPostSharesViews() {
//     sharesIconBackground.backgroundColor = UIColor.tertiarySystemFill
//     sharesIconBackground.layer.cornerRadius = iconBackgroundSize / 2
//     sharesIconBackground.clipsToBounds = true
//
//     sharesIconView.image = UIImage(named: "messenger") ?? UIImage(systemName: "message")
//     sharesIconView.contentMode = .scaleAspectFit
//     sharesIconView.tintColor = .label
//
//     Style.styleSocialCountText(sharesCountLabel)
//     sharesCountLabel.text = "5"
//     sharesCountLabel.lineBreakMode = .byTruncatingTail
//
//     [postSharesView, sharesIconBackground, sharesIconView, sharesCountLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
//     postSharesView.addSubview(sharesIconBackground)
//     sharesIconBackground.addSubview(sharesIconView)
//     postSharesView.addSubview(sharesCountLabel)
//
//     NSLayoutConstraint.activate([
//         postSharesView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
//         sharesIconBackground.leadingAnchor.constraint(equalTo: postSharesView.leadingAnchor),
//         sharesIconBackground.centerYAnchor.constraint(equalTo: postSharesView.centerYAnchor),
//         sharesIconBackground.widthAnchor.constraint(equalToConstant: iconBackgroundSize),
//         sharesIconBackground.heightAnchor.constraint(equalToConstant: iconBackgroundSize),
//         sharesIconView.centerXAnchor.constraint(equalTo: sharesIconBackground.centerXAnchor),
//         sharesIconView.centerYAnchor.constraint(equalTo: sharesIconBackground.centerYAnchor),
//         sharesIconView.widthAnchor.constraint(equalToConstant: iconSize),
//         sharesIconView.heightAnchor.constraint(equalToConstant: iconSize),
//         sharesCountLabel.leadingAnchor.constraint(equalTo: sharesIconBackground.trailingAnchor, constant: 4),
//         sharesCountLabel.centerYAnchor.constraint(equalTo: postSharesView.centerYAnchor),
//         sharesCountLabel.trailingAnchor.constraint(equalTo: postSharesView.trailingAnchor),
//         sharesCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: countMaxWidth)
//     ])
// }
// */

// CELL: CommentCell
// Source: App/Main/Post/Cells/CommentCell.swift
//
// //
// //  CommentCell.swift
// //  Kite
// //
// //  Created by David Vasquez on 4/25/25.
// //
//
// import UIKit
//
//
// //LOGIC
// //UI COMPONENTS
// //MANAGE VIEWS
// //LAYOUT and UI
// //ACTIONS
// //FUNCTIONS
//
//
// final class CommentCell: UITableViewCell {
//
//     //LOGIC
//     // Step 3 = owner-only Delete menu.
//     private var usersDataController: UsersDataController { UsersDataController.shared }
//     private var postDataController: PostDataController { PostDataController.shared }
//     private var loadUserName: String?
//     private var commentID: Int?
//     private var postID: Int?
//
//     //UI COMPONENTS
//     //Left: User Image
//     private let userImageArea = UIView()
//     private let userProfileImageView = UIImageView()
//
//     //Right Column
//     private let commentHeaderView = UIView()
//     private let userNameLabel = UILabel()
//     private let postedAtLabel = UILabel()
//     private let menuButton = UIButton(type: .system)
//
//     private let commentBodyView = UIView()
//     private let commentBodyLabel = UILabel()
//
//     private let commentFooterView = UIView()
//     private let likeImageView = UIImageView()
//     private let likeCountLabel = UILabel()
//
//     //MANAGE VIEWS
//     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//         super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//         selectionStyle = .none
//         separatorInset = .zero
//         layoutMargins = .zero
//         preservesSuperviewLayoutMargins = false
//         backgroundColor = Colors.screenBackground
//         contentView.backgroundColor = Colors.screenBackground
//
//         setupCommentViews()
//         setupDeleteMenu()
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//
//     private func setupCommentViews() {
//         setupUserImageArea()
//         setupCommentHeaderView()
//         setupCommentBodyView()
//         setupCommentFooterView()
//     }
//
//     //LAYOUT and UI
//     //LEFT: User Image Area — smaller avatar (matches PostCaption)
//     private func setupUserImageArea() {
//         userImageArea.backgroundColor = Colors.screenBackground
//         userImageArea.translatesAutoresizingMaskIntoConstraints = false
//
//         userProfileImageView.image = UIImage(named: "user") ?? UIImage(named: "background_1")
//         ImageStyle.userProfileImage(imageView: userProfileImageView, diameter: 38)
//         userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
//
//         contentView.addSubview(userImageArea)
//         userImageArea.addSubview(userProfileImageView)
//
//         NSLayoutConstraint.activate([
//             userImageArea.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//             userImageArea.topAnchor.constraint(equalTo: contentView.topAnchor),
//             userImageArea.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//             userImageArea.widthAnchor.constraint(equalToConstant: 46),
//
//             userProfileImageView.topAnchor.constraint(equalTo: userImageArea.topAnchor, constant: 8),
//             userProfileImageView.leadingAnchor.constraint(equalTo: userImageArea.leadingAnchor, constant: 2),
//             userProfileImageView.trailingAnchor.constraint(equalTo: userImageArea.trailingAnchor, constant: -6),
//             userProfileImageView.widthAnchor.constraint(equalToConstant: 38),
//             userProfileImageView.heightAnchor.constraint(equalToConstant: 38)
//         ])
//     }
//
//     //RIGHT: Comment Header — [username] [time] ........ [menu]
//     private func setupCommentHeaderView() {
//         commentHeaderView.backgroundColor = Colors.screenBackground
//         commentHeaderView.translatesAutoresizingMaskIntoConstraints = false
//
//         userNameLabel.font = Fonts.postUsernameFont
//         userNameLabel.textColor = Colors.primaryGrayText
//         userNameLabel.numberOfLines = 1
//         userNameLabel.lineBreakMode = .byTruncatingTail
//         userNameLabel.text = "username"
//         userNameLabel.translatesAutoresizingMaskIntoConstraints = false
//
//         postedAtLabel.font = Fonts.postedAtFont
//         postedAtLabel.textColor = Colors.postedAtTextColor
//         postedAtLabel.numberOfLines = 1
//         postedAtLabel.lineBreakMode = .byTruncatingTail
//         postedAtLabel.text = "now"
//         postedAtLabel.translatesAutoresizingMaskIntoConstraints = false
//
//         menuButton.translatesAutoresizingMaskIntoConstraints = false
//         menuButton.setImage(UIImage(named: "menu-dots-gray"), for: .normal)
//         menuButton.tintColor = .systemGray
//         menuButton.imageView?.contentMode = .scaleAspectFit
//         menuButton.contentHorizontalAlignment = .fill
//         menuButton.contentVerticalAlignment = .fill
//         menuButton.isHidden = true
//
//         userNameLabel.setContentHuggingPriority(.required, for: .horizontal)
//         userNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//
//         postedAtLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//         postedAtLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//
//         menuButton.setContentHuggingPriority(.required, for: .horizontal)
//         menuButton.setContentCompressionResistancePriority(.required, for: .horizontal)
//
//         contentView.addSubview(commentHeaderView)
//         commentHeaderView.addSubview(userNameLabel)
//         commentHeaderView.addSubview(postedAtLabel)
//         commentHeaderView.addSubview(menuButton)
//
//         NSLayoutConstraint.activate([
//             commentHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
//             commentHeaderView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
//             commentHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//             commentHeaderView.heightAnchor.constraint(equalToConstant: 28),
//
//             userNameLabel.leadingAnchor.constraint(equalTo: commentHeaderView.leadingAnchor),
//             userNameLabel.centerYAnchor.constraint(equalTo: commentHeaderView.centerYAnchor),
//
//             postedAtLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 4),
//             postedAtLabel.centerYAnchor.constraint(equalTo: commentHeaderView.centerYAnchor, constant: 1),
//             postedAtLabel.trailingAnchor.constraint(lessThanOrEqualTo: menuButton.leadingAnchor, constant: -8),
//
//             menuButton.trailingAnchor.constraint(equalTo: commentHeaderView.trailingAnchor),
//             menuButton.centerYAnchor.constraint(equalTo: commentHeaderView.centerYAnchor),
//             menuButton.widthAnchor.constraint(equalToConstant: 26),
//             menuButton.heightAnchor.constraint(equalToConstant: 26)
//         ])
//     }
//
//     //RIGHT: Comment Body — expanding caption
//     private func setupCommentBodyView() {
//         commentBodyView.backgroundColor = Colors.screenBackground
//         commentBodyView.translatesAutoresizingMaskIntoConstraints = false
//
//         commentBodyLabel.font = Fonts.postCaptionFont
//         commentBodyLabel.textColor = Colors.postCaptionFontColor
//         commentBodyLabel.numberOfLines = 0
//         commentBodyLabel.text = "Comment body"
//         commentBodyLabel.translatesAutoresizingMaskIntoConstraints = false
//
//         commentBodyLabel.setContentHuggingPriority(.required, for: .vertical)
//         commentBodyLabel.setContentCompressionResistancePriority(.required, for: .vertical)
//
//         contentView.addSubview(commentBodyView)
//         commentBodyView.addSubview(commentBodyLabel)
//
//         NSLayoutConstraint.activate([
//             commentBodyView.topAnchor.constraint(equalTo: commentHeaderView.bottomAnchor, constant: -4),
//             commentBodyView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
//             commentBodyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
//
//             commentBodyLabel.topAnchor.constraint(equalTo: commentBodyView.topAnchor),
//             commentBodyLabel.leadingAnchor.constraint(equalTo: commentBodyView.leadingAnchor),
//             commentBodyLabel.trailingAnchor.constraint(equalTo: commentBodyView.trailingAnchor),
//             commentBodyLabel.bottomAnchor.constraint(equalTo: commentBodyView.bottomAnchor)
//         ])
//     }
//
//     //RIGHT: Comment Footer — compact likes row (stub UI for Step 1)
//     private func setupCommentFooterView() {
//         commentFooterView.backgroundColor = Colors.screenBackground
//         commentFooterView.translatesAutoresizingMaskIntoConstraints = false
//
//         likeImageView.image = UIImage(named: "like")
//         likeImageView.contentMode = .scaleAspectFit
//         likeImageView.translatesAutoresizingMaskIntoConstraints = false
//
//         likeCountLabel.font = Fonts.regular14
//         likeCountLabel.textColor = Colors.postedAtTextColor
//         likeCountLabel.text = "0"
//         likeCountLabel.textAlignment = .center
//         likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
//
//         contentView.addSubview(commentFooterView)
//         commentFooterView.addSubview(likeImageView)
//         commentFooterView.addSubview(likeCountLabel)
//
//         NSLayoutConstraint.activate([
//             commentFooterView.topAnchor.constraint(equalTo: commentBodyView.bottomAnchor, constant: 4),
//             commentFooterView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
//             commentFooterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
//             commentFooterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//             commentFooterView.heightAnchor.constraint(equalToConstant: 24),
//
//             likeImageView.leadingAnchor.constraint(equalTo: commentFooterView.leadingAnchor),
//             likeImageView.centerYAnchor.constraint(equalTo: commentFooterView.centerYAnchor),
//             likeImageView.widthAnchor.constraint(equalToConstant: 18),
//             likeImageView.heightAnchor.constraint(equalToConstant: 18),
//
//             likeCountLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 6),
//             likeCountLabel.centerYAnchor.constraint(equalTo: likeImageView.centerYAnchor)
//         ])
//     }
//
//     //ACTIONS
//     private func setupDeleteMenu() {
//         let deleteAction = UIAction(
//             title: "Delete",
//             image: UIImage(systemName: "trash"),
//             attributes: .destructive
//         ) { [weak self] _ in
//             self?.confirmDelete()
//         }
//
//         menuButton.menu = UIMenu(children: [deleteAction])
//         menuButton.showsMenuAsPrimaryAction = true
//     }
//
//     private func confirmDelete() {
//         guard let viewController = findViewController() else { return }
//
//         let alert = UIAlertController(
//             title: "Delete Comment?",
//             message: "Are you sure you want to delete this comment? This cannot be undone.",
//             preferredStyle: .alert
//         )
//         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//         alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
//             self?.deleteComment()
//         })
//
//         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//             viewController.present(alert, animated: true)
//         }
//     }
//
//     private func deleteComment() {
//         guard let commentID, let postID else {
//             print("Delete Comment: missing commentID or postID")
//             return
//         }
//
//         Task {
//             let success = await PostLogic.shared.deleteComment(postID: postID, commentID: commentID)
//             await MainActor.run {
//                 if !success {
//                     self.showDeleteFailedAlert()
//                 }
//             }
//         }
//     }
//
//     private func showDeleteFailedAlert() {
//         guard let viewController = findViewController() else { return }
//         let alert = UIAlertController(
//             title: "Couldn’t delete comment",
//             message: "Something went wrong. Please try again.",
//             preferredStyle: .alert
//         )
//         alert.addAction(UIAlertAction(title: "OK", style: .default))
//         viewController.present(alert, animated: true)
//     }
//
//     override func prepareForReuse() {
//         super.prepareForReuse()
//
//         loadUserName = nil
//         commentID = nil
//         postID = nil
//
//         userProfileImageView.image = UIImage(named: "user") ?? UIImage(named: "background_1")
//         userNameLabel.text = "username"
//         postedAtLabel.text = "now"
//         commentBodyLabel.text = "Comment body"
//         likeCountLabel.text = "0"
//         likeImageView.image = UIImage(named: "like")
//         menuButton.isHidden = true
//     }
//
//     //FUNCTIONS
//     func configureCommentCell(with comment: Comment) {
//         commentID = comment.commentID
//         postID = comment.postID
//
//         let username = comment.userName ?? comment.commentFrom
//         userNameLabel.text = (username?.isEmpty == false) ? username : "username"
//         postedAtLabel.text = comment.timeMessage ?? "now"
//
//         if let caption = comment.commentCaption, !caption.isEmpty {
//             commentBodyLabel.text = caption
//         } else {
//             commentBodyLabel.text = "Comment body"
//         }
//
//         let likeCount = comment.commentLikeCount ?? comment.commentLikes?.count ?? 0
//         likeCountLabel.text = "\(likeCount)"
//         likeImageView.image = (comment.commentLikedByCurrentUser == true)
//             ? (UIImage(named: "liked") ?? UIImage(systemName: "heart.fill"))
//             : (UIImage(named: "like") ?? UIImage(systemName: "heart"))
//
//         let author = comment.commentFrom ?? comment.userName ?? ""
//         let currentUser = postDataController.currentUser
//         menuButton.isHidden = author.isEmpty
//             || author.caseInsensitiveCompare(currentUser) != .orderedSame
//
//         if let username, !username.isEmpty {
//             loadUserProfile(username: username)
//         } else {
//             loadUserName = nil
//             userProfileImageView.image = UIImage(named: "user") ?? UIImage(named: "background_1")
//         }
//     }
//
//     private func loadUserProfile(username: String) {
//         loadUserName = username
//
//         Task {
//             guard let user = await usersDataController.getOrFetchUserWithImage(username: username) else {
//                 return
//             }
//
//             guard loadUserName == username else { return }
//
//             await MainActor.run {
//                 guard self.loadUserName == username else { return }
//                 if let image = user.profileImage {
//                     self.userProfileImageView.image = image
//                 }
//             }
//         }
//     }
//
//     private func findViewController() -> UIViewController? {
//         var responder: UIResponder? = self
//         while let next = responder?.next {
//             if let viewController = next as? UIViewController {
//                 return viewController
//             }
//             responder = next
//         }
//         return nil
//     }
// }

// =============================================================================
// HEADER: IndividualGroupViewController
// Live cell: PostCell (same cell as IndividualPostViewController)
// Style: same PostCell style listed above
// Commented out in the controller, not used: HomePostCell
// Older commented copies later in IndividualGroupViewController.swift are not this screen.
// Those copies name IndividualGroupPostCell and IndividualPostCell.
// =============================================================================
//
// CODE
// Source: App/Main/IndividualGroup/IndividualGroupViewController.swift
//
// private func setupTableView() {
//     tableView.register(PostCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifier.postCell)
//     // tableView.register(HomePostCell.self, forCellReuseIdentifier: "HomePostCell")
//     tableView.rowHeight = UITableView.automaticDimension
//     tableView.estimatedRowHeight = 700
//     tableView.separatorStyle = .none
//     tableView.backgroundColor = Colors.feedBackground
// }
//
// func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//     guard let groupID = groupID else { return UITableViewCell() }
//     let posts = postDataController.getPostsForGroup(groupID: groupID)
//     let post = posts[indexPath.row]
//     let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.postCell, for: indexPath) as! PostCell
//     cell.updatePost(with: post)
//     return cell
// }
//
