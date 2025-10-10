//
//  AuthService.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class AuthService {
    static var storeRoot = Firestore.firestore()
    
    static func getUserId(userId: String) -> DocumentReference {
        return storeRoot.collection("users").document(userId)
    }
    
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping(_ user: User) -> Void,
                       onError: @escaping (_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { userData, error in
            if error != nil {
                onError(error?.localizedDescription ?? "Error creating user")
                return
            }
            guard let userId = userData?.user.uid else { return }
            let storageProfileUserId = StorageService.storeProfileId(userID: userId)
            
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            StorageService.saveProfileImage(userId: userId, username: username, email: email, imageData: imageData, medatData: metaData, storageProfileImageRef: storageProfileUserId, onSuccess: onSuccess, onError: onError)
        }
    }
    
    static func signIn(email: String, password: String, onSuccess: @escaping(_ user: User) -> Void,
                       onError: @escaping (_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authData, error in
            if error != nil {
                onError(error?.localizedDescription ?? "Error signing in user")
                return
            }
            guard let userId = authData?.user.uid else { return }
            let firestoreUserId = getUserId(userId: userId)
            firestoreUserId.getDocument { document, error in
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                if let dict = document?.data() {
                    guard let decodeUser = try? User.init(fromDictionary: dict) else { return }
                    onSuccess(decodeUser)
                }
            }
        }
    }
}
