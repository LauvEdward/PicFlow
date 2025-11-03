//
//  FollowService.swift
//  PicFlow
//
//  Created by Lauv Edward on 11/3/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FollowService {
    static func follower(_ userId: String) -> DocumentReference {
        return AuthService.storeRoot.collection("followers").document(userId)
    }
    static func following(_ userId: String) -> DocumentReference {
        return AuthService.storeRoot.collection("followings").document(userId)
    }
    
    static func follow(_ userId: String) {
        guard let currentUserId = Auth.auth().currentUser?.self.uid else { return }
        following(currentUserId).collection("following").document(userId).setData([:])
        follower(userId).collection("follower").document(currentUserId).setData([:])
    }
    
    static func unfollow(_ userId: String) {
        guard let currentUserId = Auth.auth().currentUser?.self.uid else { return }
        following(currentUserId).collection("following").document(userId).delete()
        follower(userId).collection("follower").document(currentUserId).delete()
    }
    
    static func checkIsFollowing(_ userId: String, completion: @escaping (Bool) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.self.uid else { return }
        following(currentUserId).collection("following").document(userId).getDocument { (document, error) in
            if let _ = document, document!.exists {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
