//
//  NotificationModel.swift
//  PicFlow
//
//  Created by Lauv Edward on 11/3/25.
//

import Foundation

struct NotificationModel: Identifiable, Codable {
    var id = UUID()
    var isLike: Bool
    var name: String
    var date: Date
    var image: String
    var postId: String
    var userId: String
    var postImage: String
}
