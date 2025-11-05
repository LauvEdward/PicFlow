//
//  ProfileView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: SessionStore
    @Environment(\.dismiss) var dismiss
    @State private var tabSelected: Int = 1
    @State private var listPost: [PostModel] = []
    @State private var showAlert = false
    @State private var isFollowing: Bool = false
    @State private var following: Int = 0
    @State private var follower: Int = 0
    
    private var isUser: Bool
    private var user: User
    
    init (user: User, isUser: Bool = false) {
        self.user = user
        self.isUser = isUser
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack (pinnedViews: .sectionHeaders) {
                    Section {
                        VStack {
                            HStack(alignment: .center) {
                                if !isUser {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                        Text("Back")
                                    }.onTapGesture {
                                        dismiss()
                                    }
                                }
                                Spacer()
                                HStack {
                                    Image(systemName: "lock.fill")
                                    Text("\(user.username)")
                                    Image(systemName: "chevron.down")
                                }
                                Spacer()
                                if isUser {
                                    Image(systemName: "iphone.and.arrow.forward.outward")
                                        .onTapGesture {
                                            showAlert = true
                                        }
                                }
                            }
                            HStack {
                                PFCacheImage.init(url: user.profileImageURL)
                                .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                .clipShape(RoundedRectangle(cornerRadius: geometry.size.width / 10, style: .continuous))
                                Spacer()
                                HStack(spacing: 20) {
                                    VStack {
                                        Text("\(listPost.count)")
                                            .bold()
                                        Text("Post")
                                    }
                                    VStack {
                                        Text("\(follower)")
                                            .bold()
                                        Text("Followers")
                                    }
                                    VStack {
                                        Text("\(following)")
                                            .bold()
                                        Text("Following")
                                    }
                                }
                                Spacer()
                            }
                            .padding([.bottom], 10)
                            HStack {
                                VStack(alignment:.leading) {
                                    if ((user.username.isEmpty) == false) {
                                        Text(user.username)
                                            .bold()
                                    }
                                    if ((user.bio.isEmpty) == false) {
                                        Text("Digital goodies designer @pixsellz")
                                            .fontWeight(.light)
                                    }
                                }
                                Spacer()
                            }
                            if isUser {
                                Button {
                                    
                                } label: {
                                    Text("Edit Profile")
                                        .bold()
                                        .foregroundColor(.black)
                                }
                                .frame(width: geometry.size.width / 1.2, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                            } else {
                                Button {
                                    if isFollowing {
                                        FollowService.unfollow(user.uid)
                                        isFollowing = false
                                    } else {
                                        FollowService.follow(user.uid)
                                        NotificationService.addNotification(.follow, notiUserId: user.uid, userId: session.session!)
                                        isFollowing = true
                                    }
                                    ProfileService.getFollowUser(userId: user.uid) { following in
                                        self.following = following
                                    } follower: { follower in
                                        self.follower = follower
                                    }
                                } label: {
                                    Text(isFollowing ? "Unfollow" : "Follow")
                                        .bold()
                                        .foregroundColor(.black)
                                }
                                .frame(width: geometry.size.width / 1.2, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                            }
                            
                            Spacer()
                        }.padding()
                    }
                    Section {
                        if tabSelected == 1 {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 100)), count: 3)) {
                                ForEach(listPost, id: \.postId) { post in
                                    PFCacheImage.init(url: post.imageUrl)
                                    .frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
                                    .clipShape(RoundedRectangle(cornerRadius: PFTheme.radius, style: .continuous))

                                }
                            }
                        } else {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 100)), count: 1)) {
                                ForEach(listPost, id: \.postId) { post in
                                    PFPostCardView(post: post)
                                }
                            }
                        }
                    } header: {
                        HStack {
                            Spacer()
                            VStack {
                                Image(systemName: "squareshape.split.3x3")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(tabSelected == 1 ? .black : .gray)
                                Divider()
                                    .background(tabSelected == 1 ? .black : .gray)
                            }
                            .onTapGesture {
                                tabSelected = 1
                            }
                            Spacer()
                            Spacer()
                            VStack {
                                Image(systemName: "person.crop.square.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(tabSelected != 1 ? .black : .gray)
                                Divider()
                                    .background(tabSelected != 1 ? .black : .gray)
                            }
                            .onTapGesture {
                                tabSelected = 2
                            }
                            Spacer()
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
        }
        .task {
            ProfileService.getAllPostFromUser(userId: user.uid) { posts in
                listPost = posts
            }
            ProfileService.getFollowUser(userId: user.uid) { following in
                self.following = following
            } follower: { follower in
                self.follower = follower
            }

            if !isUser {
                FollowService.checkIsFollowing(user.uid) { isFollowing in
                    self.isFollowing = isFollowing
                }
            }
        }
        .alert("Logout", isPresented: $showAlert) {
            // Actions for the alert
            Button("OK") {
                session.logout()
            }
            Button("Cancel", role: .cancel) {
                showAlert = false
            }
        } message: {
            Text("Do you really want to sign out of your account?")
        }
    }
}
