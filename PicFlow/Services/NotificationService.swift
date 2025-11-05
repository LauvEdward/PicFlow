//
//  NotificationService.swift
//  PicFlow
//
//  Created by Lauv Edward on 11/3/25.
//

import Foundation
import Combine
import FirebaseFirestore

class NotificationService: ObservableObject {
    @Published var listNotification: [NotificationModel] = []
    private var listener: ListenerRegistration?
    
    init() {
    }
    
    func fetchNotification(userId: String) {
        listener = AuthService.storeRoot.collection("notifications").document(userId).collection("notifications").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.listNotification = []
            for item in snapshot?.documents ?? [] {
                let noti = try? item.data(as: NotificationModel.self)
                guard let noti = noti else { return }
                self.listNotification.append(noti)
            }
        }
    }
    
    static func addNotification(_ typeNotification: TypeNotification, notiUserId: String, userId: User, postId: String = "", postImage: String = "") {
        if notiUserId == userId.uid { return }
        var notification = NotificationModel(isLike: false, iscomment: false, isFollow: false, name: userId.username, date: Date().timeIntervalSince1970, image: userId.profileImageURL, postId: postId, userId: userId.uid, postImage: postImage)
        switch typeNotification {
            case .like:
            notification.isLike = true
        case .comment:
            notification.iscomment = true
        case .follow:
            notification.isFollow = true
        }
        let notiDict = try? notification.asDictionary()
        guard let notiDict = notiDict else { return }
        AuthService.storeRoot.collection("notifications").document(notiUserId).collection("notifications").addDocument(data: notiDict)
    }
    
    deinit {
        print("deinit NotificationService")
        listener?.remove()
        listener = nil
    }
    
}
