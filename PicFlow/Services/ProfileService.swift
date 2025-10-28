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
    static func getAllPostFromUser(onSuccess: @escaping ([PostModel]) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
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
}
