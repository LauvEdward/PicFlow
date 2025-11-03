//
//  ProfileService.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/28/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileService {
    static func getAllPostFromUser(userId: String ,onSuccess: @escaping ([PostModel]) -> Void) {
        var posts = [PostModel]()
        PostService.postUserId(userId: userId).collection("posts").getDocuments { (snapshot, error) in
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
    
    static func getFollowUser(userId: String ,following: @escaping (Int) -> Void, follower: @escaping (Int) -> Void) {
        FollowService.following(userId).collection("following").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                following(snapshot!.count)
            }
        }
        FollowService.follower(userId).collection("follower").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                follower(snapshot!.count)
            }
        }
    }
}
