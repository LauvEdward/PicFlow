//
//  PostCardView.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/28/25.
//

import SwiftUI

struct PFPostCardView: View {
    @ObservedObject var postCardService: PostCardService
    @EnvironmentObject var session: SessionStore
    @State private var isExpanded: Bool = false
    
    init(post: PostModel) {
        postCardService = PostCardService(post: post)
    }
    init(postCardService: PostCardService) {
        self.postCardService = postCardService
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
                        .animation(.easeInOut, value: postCardService.isLiked)
                        .onTapGesture {
                            postCardService.like()
                            NotificationService.addNotification(.like, notiUserId: postCardService.post.userId, userId: session.session!, postId: postCardService.post.postId, postImage: postCardService.post.imageUrl)
                        }
                    
                }
                NavigationLink {
                    PostDetailView(post: postCardService.post)
                        .navigationBarHidden(true)
                        .background(Color.black.opacity(0.05))
                } label: {
                    Image(systemName: "message")
                }
                .foregroundColor(.black)
                Image(systemName: "arrow.2.squarepath")
                Image(systemName: "paperplane")
                Spacer()
                Image(systemName: "bookmark")
            }
            .padding(5)
            HStack {
                VStack(alignment: .leading) {
                    Text(postCardService.post.caption)
                        .lineLimit(isExpanded ? 10 : 1)
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
    var stateObject = PostCardService(post: PostModel.init(caption: "Description", postId: "abc", userId: "phucld", imageUrl: "", username: "Phuc Dep Trai", date: 123456789, likeCount: 1, geoLocation: "", likes: [:], profile: ""))
    PFPostCardView(postCardService: stateObject)
}
