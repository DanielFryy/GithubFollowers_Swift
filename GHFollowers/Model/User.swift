//
//  User.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/17/24.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var follower: Int
    var following: Int
    var createdAt: String
}
