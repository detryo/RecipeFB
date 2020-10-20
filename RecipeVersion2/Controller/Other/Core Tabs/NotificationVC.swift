//
//  NotificationVC.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit

enum UserNotificationType {
    
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationVC: UIViewController {

    private var models = [UserNotification]()
    private lazy var noNotificationsView = NoNotificationsView()
    
    // Design UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventCell.self, forCellReuseIdentifier: Identifier.notificationLikeEventCell)
        tableView.register(NotificationFollowEventCell.self, forCellReuseIdentifier: Identifier.notificationFollowEventCell)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNotifications()
        
        navigationItem.title = "Notifications"
        
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
        
        spinner.frame = CGRect(x: 0,
                               y: 0,
                               width: 100,
                               height: 100)
        
        spinner.center = view.center
    }

    private func addNotificationsView() {
        
        tableView.isHidden = true
        view.addSubview(tableView)
        
        noNotificationsView.frame = CGRect(x: 0,
                                           y: 0,
                                           width: view.width / 2,
                                           height: view.width / 4)
        
        noNotificationsView.center = view.center
    }

    private func fetchNotifications() {
        
        for x in 0...10 {
            
            let user = User(userName: "Chris",
                            bio: "",
                            name: (first: "", last: ""),
                            birthDate: Date(),
                            joinDate: Date(),
                            gender: .male,
                            count: UserCount(followers: 1, following: 1, post: 1),
                            profilePhoto: URL(string: "https://www.google.com")!)
            
            let post = UserPost(identifier: "",
                                postType: .photo,
                                thumbnailImage: URL(string: "https://www.google.com")!,
                                postURL: URL(string: "https://www.google.com")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                createDate: Date(),
                                taggedUsers: [],
                                owner: user)
            
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                                         text: "Hellow World",
                                         user: user)
            models.append(model)
        }
    }
}

extension NotificationVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.row]
        
        switch model.type {
        
        case .like(_):
            // Like Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.notificationLikeEventCell,
                                                     for: indexPath) as! NotificationLikeEventCell
            cell.configuration(with: model)
            cell.delegate = self
            
            return cell
            
        case .follow:
            // Follow Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.notificationFollowEventCell,
                                                     for: indexPath) as! NotificationFollowEventCell
            
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 52
    }
}

extension NotificationVC: NotificationLikeEventCellDelegate {
    
    func didTapRelatedPostButton(model: UserNotification) {
        
        switch model.type {
        
        case .like(let post):
        // Open the post
        let viewController = PostVC(model: post)
            viewController.title = post.postType.rawValue
            viewController.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(viewController, animated: true)
            
        case .follow(_):
            fatalError("Dev error should never get called")
        }
    }
}

extension NotificationVC: NotificationFollowEventCellDelegate {
    
    func didTapFollowUnFollowButton(model: UserNotification) {
        
        print("Tapped Button")
    }
}
