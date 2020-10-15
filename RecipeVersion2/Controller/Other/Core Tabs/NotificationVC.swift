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

class NotificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


}
