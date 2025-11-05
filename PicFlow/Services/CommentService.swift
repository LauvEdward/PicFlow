//
//  ChatService.swift
//  PicFlow
//
//  Created by Lauv Edward on 11/4/25.
//

import Foundation
import Combine
import FirebaseFirestore

class CommentService: ObservableObject {
    @Published var comments: [CommentModel] = []
    private var listener: ListenerRegistration?
    
    init(post: PostModel) {
        fetchComments(postId: post.postId)
    }
    
    func fetchComments(postId: String) {
        listener = AuthService.storeRoot.collection("comments").document(postId).collection("comment").order(by: "time", descending: true).addSnapshotListener { (snapshot, error) in
            if let error {
                print(error)
                return
            }
            for item in snapshot?.documents ?? [] {
                let comment = try? item.data(as: CommentModel.self)
                guard let comment else { continue }
                self.comments.append(comment)
            }
        }
    }
    
    func comment(message: String, post: PostModel, user: User, onSuccess: @escaping () -> Void) {
        let comment: CommentModel = CommentModel(message: message, time: Date().timeIntervalSince1970, user: user)
        let commentDict = try? comment.asDictionary()
        guard let commentDict else { return }
        AuthService.storeRoot.collection("comments").document(post.postId).collection("comment").addDocument(data: commentDict) { (error) in
            if let error {
                print(error)
                return
            }
            NotificationService.addNotification(.comment, notiUserId: post.userId, userId: user, postId: post.postId, postImage: post.imageUrl)
            onSuccess()
        }
    }
    
    deinit {
        print("deinit: Comment Service")
        listener?.remove()
        listener = nil
    }
}
