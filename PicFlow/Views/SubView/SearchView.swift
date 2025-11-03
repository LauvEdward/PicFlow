//
//  SearchView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State var listUser: [User] = []

    var body: some View {
        VStack(spacing: 12) {
            TextField("Search Name", text: $searchText)
                .onChange(of: searchText) { searchText in
                    SearchService.searchUser(searchText: searchText, completion: { users in
                        listUser = users
                    })
                }
                .padding(10)
                .font(.system(size: 14))
                .frame(maxHeight: 40)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 8) {
                    ForEach(listUser, id: \.uid) { user in
                        HStack {
                            PFCacheImage(url: user.profileImageURL)
                                .frame(width: 50, height: 50)
                                .cornerRadius(25)
                                .clipped()
                                .padding(.trailing)
                            VStack(alignment: .leading) {
                                Text(user.username)
                                Text(user.email)
                            }
                        }
                    }
                }
                .padding(.top, 4)
            }
        }
        .padding()
    }
}
