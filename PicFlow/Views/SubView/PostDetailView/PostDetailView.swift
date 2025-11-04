//
//  PostDetailView.swift
//  PicFlow
//
//  Created by Lauv Edward on 11/4/25.
//

import SwiftUI

struct PostDetailView: View {
    var postCard: PostModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var session: SessionStore
    @State var textComment: String = ""
    @StateObject var commentService: CommentService
    @State var state: LoadState = .success
    
    init(post: PostModel) {
        postCard = post
        _commentService = StateObject(wrappedValue: CommentService(post: post))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                        Spacer()
                    }.onTapGesture {
                        dismiss()
                    }
                    .padding(.horizontal, 10)
                    PFPostCardView(post: postCard)
                    ForEach(commentService.comments, id: \.id) { comment in
                        HStack {
                            PFCacheImage(url: comment.user.profileImageURL)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                            VStack(alignment: .leading) {
                                Text(comment.user.username)
                                    .bold()
                                Text(comment.message)
                                Text("\(Date(timeIntervalSince1970: comment.time).timeAgoDisplay())")
                                    .font(Font.caption.bold())
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                }
            }
            HStack {
                PFTextField(value: $textComment, placeholder: "Write a comment...", isSecureTextEntry: false, isShow: true)
                if state == .loading {
                    ProgressView()
                } else {
                    HStack {
                        Text("Sent")
                        Image(systemName: "paperplane")
                    }.onTapGesture {
                        if textComment.isEmpty { return }
                        state = .loading
                        commentService.comment(message: textComment, post: postCard, user: session.session!) {
                            textComment = ""
                            state = .success
                        }
                    }
                }
            }
            .padding()
        }
    }
}
