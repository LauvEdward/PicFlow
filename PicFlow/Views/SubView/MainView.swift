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
        ScrollView {
            ForEach(listPostCard, id: \.postId) { card in
                PFPostCardView(post: card)
                    .padding(.bottom, 20)
            }
        }
        .onAppear {
            PostService.getAllPost { listPost in
                self.listPostCard = listPost
            }
        }
    }
}

#Preview {
    MainView()
}
