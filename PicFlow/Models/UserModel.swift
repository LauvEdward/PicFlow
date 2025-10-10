//
//  UserModel.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import Foundation

struct User: Codable {
    var uid: String
    var email: String
    var profileImageURL: String
    var username: String
    var searchName: [String]
    var bio: String
}
