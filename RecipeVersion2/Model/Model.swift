//
//  Model.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import Foundation

/// Represent a user post
public struct UserPost {
    
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createDate: Date
    let taggedUsers: [String]
    let owner: User
}

public enum UserPostType: String {
    
    case photo = "Photo"
    case video = "Video"
}

struct PostLike {
    
    let userName: String
    let postIdentifier: String
}

struct CommentLike {
    
    let userName: String
    let commentIdentifier: String
}

struct PostComment {
    
    let identifier: String
    let userName: String
    let text: String
    let createDate: Date
    let like: [CommentLike]
}

struct User {
    
    let userName: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let joinDate: Date
    let gender: Gender
    let count: UserCount
    let profilePhoto: URL
}

struct UserCount {
    
    let followers: Int
    let following: Int
    let post: Int
}

enum Gender {
    
    case male, famale, other
}
