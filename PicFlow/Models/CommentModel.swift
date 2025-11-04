//
//  CommentModel.swift
//  PicFlow
//
//  Created by Lauv Edward on 11/4/25.
//

import Foundation
class CommentModel: Identifiable, Codable {
    var id: UUID = UUID()
    var message: String
    var time: Double
    var user: User
    
    init(message: String, time: Double, user: User) {
        self.message = message
        self.time = time
        self.user = user
    }
}
