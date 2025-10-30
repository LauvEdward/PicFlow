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
    @Published var post: PostModel!
    @Published var isLiked: Bool = false
    
    func hasLikedPost() {
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true) ? true : false
    }
    
    func like() {
        post.likeCount += 1
        isLiked = true
        
        PostService.postUserId(userId: post.userId).collection("posts").document(post.postId)
            .updateData(["likeCount" : post.likeCount, "likes": ["\(Auth.auth().currentUser!.uid)" : true]])
        
    }
    
    func unLike() {
        post.likeCount -= 1
        isLiked = false
        
        PostService.postUserId(userId: post.userId).collection("posts").document(post.postId)
            .updateData(["likeCount" : post.likeCount, "likes": ["\(Auth.auth().currentUser!.uid)" : true]])
        
    }
}
