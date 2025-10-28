//
//  PostCardView.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/28/25.
//

import SwiftUI

struct PostCardView: View {
    @State private var isExpanded: Bool = false
    var post: PostModel
    var body: some View {
        VStack {
            HStack {
                Image("avatar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack {
                    Text(post.username)
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            AsyncImage(url: URL(string: post.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView() // Placeholder while loading
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                case .failure:
                    Image(systemName: "exclamationmark.triangle.fill") // Error indicator
                @unknown default:
                    EmptyView()
                }
            }

                
            HStack(spacing: 20) {
                Image(systemName: "heart")
                Image(systemName: "message")
                Image(systemName: "arrow.2.squarepath")
                Image(systemName: "paperplane")
                Spacer()
                Image(systemName: "bookmark")
            }
            .padding()
            HStack {
                VStack(alignment: .leading) {
                    Text(post.caption)
                        .lineLimit(isExpanded ? 3 : 1)
                        .animation(.easeInOut, value: isExpanded) // Optional: add animation for smooth expansion
                    
                    Button(action: {
                        isExpanded.toggle()
                    }) {
                        Text(isExpanded ? "Read Less" : "Read More")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    PostCardView(post: PostModel.init(caption: "Description", postId: "abc", userId: "phucld", imageUrl: "", username: "Phuc Dep Trai", date: 123456789, likeCount: 1, geoLocation: "", likes: [:], profile: ""))
}
