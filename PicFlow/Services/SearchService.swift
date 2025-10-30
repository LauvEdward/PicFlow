//
//  SearchService.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/30/25.
//

import Foundation
import FirebaseFirestore

class SearchService {
    // MARK: FIX ME - Call all user and filter in UI is not good
    // - should seperate name to array in save to searchName when register
    // - use where filed in firestore
    static func searchUser(searchText: String, completion: @escaping ([User]) -> Void) {
        let needle = searchText.lowercased()
        guard !needle.isEmpty else { completion([]); return }
        
        let q = AuthService.storeRoot
            .collection("users")
        
        q.getDocuments { snap, err in
            var users = snap?.documents.compactMap { try? User(fromDictionary: $0.data()) } ?? []
            users = users.filter { $0.username.lowercased().contains(needle)  || $0.email.lowercased().contains(needle)}
            completion(users)
        }
    }
}
