//
//  ProfileDoc.swift
//  Kite
//
//  Created by David Vasquez on 6/6/25.
//

import Foundation




/*
private func fetchFriendDetails(friendName: String) async {
    do {
        // Load friend's full profile
        let userProfileResponse = try await profileAPI.getUserProfileAPI(currentUser: friendName)
        let userData = userProfileResponse.data

        let profileImage = await imageFunctions.fetchImage(from: userData.userImage)

        DispatchQueue.main.async {
            self.userProfileLayout.userNameView.nameLabel.text = "@\(userData.userName)"
            self.userProfileLayout.userProfileBiography.configure(
                firstName: userData.firstName,
                lastName: userData.lastName
            )
            if let profileImage = profileImage {
                if let cropped = profileImage.croppedToSquare() {
                    self.userProfileLayout.profileImageView.imageView.image = cropped
                } else {
                    self.userProfileLayout.profileImageView.imageView.image = profileImage
                }
            } else {
                self.userProfileLayout.profileImageView.imageView.image = UIImage(named: "background_9")
            }
            self.userProfileLayout.profileImageView.imageView.makeRounded()
        }

    } catch {
        print("Failed to fetch friend's profile details: \(error)")
    }
}
 */


/*
class FriendListViewController: UIViewController {
    var friendUserName: String?
    var friendListArray: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = friendUserName {
            print("Viewing friend list of: \(name)")
            // Now fetch the friend list using FriendAPI
        }
    }
}

*/


/*
class FriendTableViewCell: UITableViewCell {

    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let fullNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [profileImageView, usernameLabel, fullNameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        fullNameLabel.textColor = .gray

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),

            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

            fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            fullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    func configure(with user: Friend) {
        usernameLabel.text = "@\(user.friendName)"
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        profileImageView.image = user.profileImage ?? UIImage(named: "placeholder_profile")
    }
}
*/

/*
private func configureCellActions(for user: Friend, cell: YourFriendsTableViewCell) {
    let status = FriendshipStatus(key: user.friendshipKey)

    // TYPE 1: Cancel a Friend Request you sent
    cell.cancelFriendInviteTapped = { [weak self] in
        guard let self = self else { return }
        let alert = UIAlertController(
            title: "Cancel Friend Request",
            message: "Are you sure you want to cancel the friend invite to @\(user.friendName)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remove Request", style: .destructive) { _ in
            Task {
                do {
                    let currentUser = UserDefaultManager().getLoggedInUser()
                    let response = try await FriendAPI().cancelFriendRequest(
                        masterSite: "kite", // Replace with actual value
                        currentUser: currentUser,
                        friendName: user.friendName
                    )

                    if response.success {
                        DispatchQueue.main.async {
                            print("Successfully cancelled request to \(user.friendName)")

                            // Remove from local arrays
                            self.friends.removeAll { $0.friendID == user.friendID }
                            self.currentData.removeAll { $0.friendID == user.friendID }

                            self.tableView.reloadData()

                            // Inform delegate
                            self.delegate?.didDeclineFriend(user)
                        }
                    } else {
                        print("Failed to cancel friend request: \(response.message)")
                    }
                } catch {
                    print("Error cancelling friend request: \(error)")
                }
            }
        })
        self.present(alert, animated: true)
    }


    
    // TYPE 2: Remove an existing friend
    cell.removeFriendTapped = { [weak self] in
        guard let self = self else { return }

        let alert = UIAlertController(
            title: "Remove Friend",
            message: "Are you sure you want to remove @\(user.friendName) from your friends?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { _ in
            Task {
                do {
                    let currentUser = UserDefaultManager().getLoggedInUser()
                    let response = try await FriendAPI().removeFriend(
                        masterSite: "yourMasterSiteName", // Replace with actual
                        currentUser: currentUser,
                        removeFriendName: user.friendName
                    )

                    if response.success {
                        DispatchQueue.main.async {
                            print("Successfully removed friend: \(user.friendName)")

                            // Remove from local arrays
                            self.friends.removeAll { $0.friendID == user.friendID }
                            self.currentData.removeAll { $0.friendID == user.friendID }

                            self.tableView.reloadData()

                            // Inform delegate (same as decline)
                            self.delegate?.didDeclineFriend(user)
                        }
                    } else {
                        print("Failed to remove friend: \(response.message)")
                    }
                } catch {
                    print("Error removing friend: \(error)")
                }
            }
        })
        self.present(alert, animated: true)
    }

    
    // TYPE 3: Accept a Friend request
    // Accept a Friend Request
    cell.acceptFriendInviteTapped = { [weak self] in
        guard let self = self else { return }

        Task {
            do {
                let currentUser = UserDefaultManager().getLoggedInUser()
                let response = try await FriendAPI().acceptFriendInvite(masterSite: "kite", currentUser: currentUser, friendName: user.friendName)

                if response.success {
                    DispatchQueue.main.async {
                        print("Successfully accepted friend invite from \(user.friendName)")

                        self.friendRequests.removeAll { $0.friendID == user.friendID }
                        self.currentData.removeAll { $0.friendID == user.friendID }

                        user.friendshipKey = FriendshipStatus.friends.rawValue
                        self.friends.append(user)

                        if self.segmentedControl.selectedSegmentIndex == 1 {
                            self.tableView.reloadData()
                        }

                        //Notify the delegate
                        self.delegate?.didAddFriend(user)
                    }
                } else {
                    print("Failed to accept friend invite: \(response.message)")
                }
            } catch {
                print("Error accepting friend invite: \(error)")
            }
        }
    }


    // TYPE 4: Decline a Friend Request
    cell.declineFriendInviteTapped = { [weak self] in
        guard let self = self else { return }

        print("Decline invite from \(user.friendName)")

        Task {
            do {
                let currentUser = UserDefaultManager().getLoggedInUser()
                let response = try await FriendAPI().declineFriendInvite(masterSite: "kite", currentUser: currentUser, friendName: user.friendName)

                if response.success {
                    DispatchQueue.main.async {
                        
                        // 1. Remove from data source
                        if let index = self.currentData.firstIndex(where: { $0.friendID == user.friendID }) {
                            self.currentData.remove(at: index)
                            self.friendRequests.removeAll(where: { $0.friendID == user.friendID })
                            self.users.removeAll(where: { $0.friendID == user.friendID })

                            // 2. Remove from table view
                            let indexPath = IndexPath(row: index, section: 0)
                            self.tableView.deleteRows(at: [indexPath], with: .automatic)

                            // 3. Notify delegate
                            self.delegate?.didDeclineFriend(user)
                        }
                    }
                    
                } else {
                    print("Failed to accept friend invite: \(response.message)")
                }
            } catch {
                print("Error accepting friend invite: \(error)")
            }
        }

    }
}
 
 */


/*
// Simulate success response (pretend API call)
DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
    // 1. Remove from data source
    if let index = self.currentData.firstIndex(where: { $0.friendID == user.friendID }) {
        self.currentData.remove(at: index)
        self.friendRequests.removeAll(where: { $0.friendID == user.friendID })
        self.users.removeAll(where: { $0.friendID == user.friendID })

        // 2. Remove from table view
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)

        // 3. Notify delegate
        self.delegate?.didDeclineFriend(user)
    }
}
*/
