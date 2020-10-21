//
//  UserFollowCell.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

// ESto pertenece a ListVC
import UIKit


enum FollowState {
    
    case following, not_following
}

struct UserRelationship {
    
    let userName: String
    let name: String
    let type: FollowState
}

class UserFollowCell: UITableViewCell {

    

}
