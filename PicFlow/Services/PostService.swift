//
//  PostService.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/20/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class PostService {
    static var post = AuthService.storeRoot.collection("posts")
    static var allPosts = AuthService.storeRoot.collection("allposts")
    static var timeLine = AuthService.storeRoot.collection("timeline")
    
    static func postUserId(userId: String) -> DocumentReference {
        return post.document(userId)
    }
    static func timeLineUserId(userId: String) -> DocumentReference {
        return timeLine.document(userId)
    }
    
    static func uploadPost(imageData: Data, caption: String, onSuccess: @escaping ()->Void, onError: @escaping (String)->Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let postId = PostService.postUserId(userId: userId).collection("posts").document().documentID
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let storePostRef = StorageService.storagePostId(postId: postId)
        
        StorageService.savePostImage(userId: userId, postId: postId, caption: caption, imageData: imageData, metadata: metadata, storagePostImageRef: storePostRef, onSuccess: onSuccess, onError: onError)
    }
    static func getAllPost(onSuccess: @escaping ([PostModel]) -> Void) {
        var posts = [PostModel]()
        PostService.allPosts.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    let post = try? PostModel.init(fromDictionary: document.data())
                    if let post = post {
                        posts.append(post)
                    }
                }
                onSuccess(posts)
            }
        }
    }
}
