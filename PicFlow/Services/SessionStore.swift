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
    @Published var loading = true
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        listen()
    }
    
    func listen() {
        loading = true
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                let firestoreUserId = AuthService.getUserId(userId: user.uid)
                firestoreUserId.getDocument { (document, user) in
                    if let dict = document?.data() {
                        guard let decodeUser = try? User.init(fromDictionary: dict) else { return }
                        self.loading = false
                        self.session = decodeUser
                    }
                }
                self.loading = false
            } else {
                self.loading = false
                self.session = nil
            }
        }
    }
        
    func logout() {
        do {
            try Auth.auth().signOut()
            unbind()
            self.loading = false
        } catch {
            self.loading = false
        }
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
