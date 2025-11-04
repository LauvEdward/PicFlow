//
//  SessionStore.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth

class SessionStore: ObservableObject {
    @Published var session: User?
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        listen()
    }
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                let firestoreUserId = AuthService.getUserId(userId: user.uid)
                firestoreUserId.getDocument { (document, error) in
                    if let dict = document?.data() {
                        guard let decodeUser = try? User.init(fromDictionary: dict) else { return }
                        self.session = decodeUser
                    }
                }
            } else {
                self.session = nil
            }
        }
    }
        
    func logout() {
        do {
            try Auth.auth().signOut()
            ImageCache.shared.clearCache()
            unbind()
        } catch {
        }
        self.session = nil
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        print("Deinit")
    }
}
