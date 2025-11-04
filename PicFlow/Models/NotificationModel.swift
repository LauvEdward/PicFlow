//
//  NotificationModel.swift
//  PicFlow
//
//  Created by Lauv Edward on 11/3/25.
//

import Foundation

enum TypeNotification {
    case like
    case comment
    case follow
}

struct NotificationModel: Identifiable, Codable {
    var id = UUID()
    var isLike: Bool
    var iscomment: Bool
    var isFollow: Bool
    var name: String
    var date: Double
    var image: String
    var postId: String
    var userId: String
    var postImage: String
    init(isLike: Bool, iscomment: Bool, isFollow: Bool, name: String, date: Double, image: String, postId: String, userId: String, postImage: String) {
        self.isLike = isLike
        self.iscomment = iscomment
        self.isFollow = isFollow
        self.name = name
        self.date = date
        self.image = image
        self.postId = postId
        self.userId = userId
        self.postImage = postImage
    }
}
