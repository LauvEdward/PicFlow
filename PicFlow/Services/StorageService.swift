//
//  StorageService.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class StorageService {
    
    static var storage = Storage.storage()
    
    static var storageRef: StorageReference = storage.reference(forURL: "gs://picflow-65d5d.firebasestorage.app")
    
    static var profileImage = storageRef.child("profile")
    static var postImage = storageRef.child("post")
    
    static func storeProfileId(userID: String) -> StorageReference {
        return profileImage.child(userID)
    }
    
    static func storagePostId(postId: String) -> StorageReference {
        return postImage.child(postId)
    }
    
    static func saveProfileImage(userId: String, username: String, email: String, imageData: Data,
                                 medatData: StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errMessage: String) -> Void) {
        storageProfileImageRef.putData(imageData, metadata: medatData) { (_, error) in
            if error != nil {
                onError(error?.localizedDescription ?? "Error saveProfileImage")
                return
            }
            
            storageProfileImageRef.downloadURL() { (url, error) in
                if error != nil {
                    onError(error?.localizedDescription ?? "Error downloadURL")
                    return
                }
                
                if let metaImageURl = url?.absoluteString {
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.displayName = username
                        changeRequest.photoURL = URL(string: metaImageURl)
                        changeRequest.commitChanges { error in
                            if let error = error {
                                onError(error.localizedDescription)
                                return
                            }
                        }
                    }
                    
                    let firestoreUserid = AuthService.getUserId(userId: userId)
                    
                    let user = User(uid: userId, email: email, profileImageURL: metaImageURl, username: username, searchName: [], bio: "")
                    guard let dict = try? user.asDictionary() else { return }
                    firestoreUserid.setData(dict) {
                        (error) in
                        if error != nil {
                            onError(error?.localizedDescription ?? "firestoreUserid setData")
                            return
                        }
                    }
                    onSuccess(user)
                }
            }
        }
    }
    
    static func savePostImage(userId: String, postId: String, caption: String, imageData: Data, metadata: StorageMetadata, storagePostImageRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errMessage: String) -> Void) {
        storagePostImageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            
            storagePostImageRef.downloadURL() { (url, error) in
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let postImageUrl = url else { return }
                let postModel = PostModel(caption: caption, postId: postId, userId: userId, imageUrl: postImageUrl.absoluteString, username: Auth.auth().currentUser?.displayName ?? "", date: Date().timeIntervalSince1970, likeCount: 0, geoLocation: "", likes: [:], profile: Auth.auth().currentUser?.photoURL?.absoluteString ?? "")
                guard let dict = try? postModel.asDictionary() else { return }
                
                let fireStore = PostService.postUserId(userId: userId).collection("posts").document(postId)
                
                fireStore.setData(dict) {
                    error in
                    if let error = error {
                        onError(error.localizedDescription)
                        return
                    }
                    PostService.timeLineUserId(userId: userId).collection("timeline").document(postId).setData(dict)
                    PostService.allPosts.document(postId).setData(dict)
                    onSuccess()
                }
            }
        }
    }
}
