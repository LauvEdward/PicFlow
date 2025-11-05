//
//  MainView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 12/10/25.
//

import SwiftUI

struct MainView: View {
    @State var listPostCard: [PostModel] = []
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(listPostCard, id: \.postId) { card in
                    PFPostCardView(post: card)
                        .padding(.bottom, 20)
                }
            }
            .background(Color.black.opacity(0.05))
        }
        .task {
            PostService.getAllPost { listPost in
                self.listPostCard = listPost
            }
        }
    }
}

#Preview {
    MainView()
}
