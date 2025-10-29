//
//  PostCardView.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/28/25.
//

import SwiftUI

struct PFPostCardView: View {
    @ObservedObject var postCardService = PostCardService()
    @State private var isExpanded: Bool = false
    
    init(post: PostModel) {
        self.postCardService.post = post
        self.postCardService.hasLikedPost()
    }
    var body: some View {
        VStack {
            HStack {
                PFCacheImage(url: postCardService.post.profile)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                VStack {
                    Text(postCardService.post.username)
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            PFCacheImage.init(url: postCardService.post.imageUrl)
            HStack(spacing: 20) {
                if postCardService.isLiked {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .onTapGesture {
                            postCardService.unLike()
                        }
                } else {
                    Image(systemName: "heart")
                        .onTapGesture {
                            postCardService.like()
                        }
                    
                }
                Image(systemName: "message")
                Image(systemName: "arrow.2.squarepath")
                Image(systemName: "paperplane")
                Spacer()
                Image(systemName: "bookmark")
            }
            .padding(5)
            HStack {
                VStack(alignment: .leading) {
                    Text(postCardService.post.caption)
                        .lineLimit(isExpanded ? 3 : 1)
                        .animation(.easeInOut, value: isExpanded)
                    
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
            .padding([.bottom], 10)
        }
    }
}

#Preview {
    PFPostCardView(post: PostModel.init(caption: "Description", postId: "abc", userId: "phucld", imageUrl: "", username: "Phuc Dep Trai", date: 123456789, likeCount: 1, geoLocation: "", likes: [:], profile: ""))
}
