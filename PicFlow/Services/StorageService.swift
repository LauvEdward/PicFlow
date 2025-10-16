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
    
    static func storeProfileId(userID: String) -> StorageReference {
        return profileImage.child(userID)
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
}
