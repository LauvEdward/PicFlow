//
//  PostModel.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/20/25.
//

import Foundation

struct PostModel: Codable {
    var caption: String
    var postId: String
    var userId: String
    var imageUrl: String
    var username: String
    var date: Double
    var likeCount: Int
    var geoLocation: String
    var likes: [String: Bool]
    var profile: String
    
    init(caption: String, postId: String, userId: String, imageUrl: String, username: String, date: Double, likeCount: Int, geoLocation: String, likes: [String : Bool], profile: String) {
        self.caption = caption
        self.postId = postId
        self.userId = userId
        self.imageUrl = imageUrl
        self.username = username
        self.date = date
        self.likeCount = likeCount
        self.geoLocation = geoLocation
        self.likes = likes
        self.profile = profile
    }
}
