//
//  PostCardService.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 29/10/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine
class PostCardService: ObservableObject {
    @Published var post: PostModel
    @Published var isLiked: Bool = false
    
    init(post: PostModel) {
        self.post = post
        self.hasLikedPost()
    }
    
    func hasLikedPost() {
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true) ? true : false
    }
    
    func like() {
        post.likeCount += 1
        isLiked = true
        guard let userId = Auth.auth().currentUser?.uid else { return }
        PostService.postUserId(userId: post.userId).collection("posts").document(post.postId)
            .updateData(["likeCount" : post.likeCount, "likes": ["\(userId)" : true]])
        PostService.timeLineUserId(userId: post.userId).collection("timeline").document(post.postId)
            .updateData(["likeCount" : post.likeCount, "likes": ["\(userId)" : true]])
        PostService.allPosts.document(post.postId)
            .updateData(["likeCount" : post.likeCount, "likes": ["\(userId)" : true]])
        
    }
    
    func unLike() {
        post.likeCount -= 1
        isLiked = false
        guard let userId = Auth.auth().currentUser?.uid else { return }
        PostService.postUserId(userId: post.userId).collection("posts").document(post.postId)
            .updateData(["likeCount" : post.likeCount, "likes": ["\(userId)" : true]])
        PostService.timeLineUserId(userId: post.userId).collection("timeline").document(post.postId)
            .updateData(["likeCount" : post.likeCount, "likes": ["\(userId)" : true]])
        PostService.allPosts.document(post.postId)
            .updateData(["likeCount" : post.likeCount, "likes": ["\(userId)" : true]])
        
    }
}
