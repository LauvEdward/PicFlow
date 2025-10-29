//
//  ProfileView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: SessionStore
    @State private var tabSelected: Int = 1
    @State private var listPost: [PostModel] = []
    @State private var showAlert = false
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack (pinnedViews: .sectionHeaders) {
                    Section {
                        VStack {
                            HStack(alignment: .center) {
                                Spacer()
                                HStack {
                                    Image(systemName: "lock.fill")
                                    Text("\(session.session?.username ?? "")")
                                    Image(systemName: "chevron.down")
                                }
                                Spacer()
                                Image(systemName: "line.3.horizontal")
                                    .onTapGesture {
                                        showAlert = true
                                    }
                            }
                            HStack {
                                PFCacheImage.init(url: session.session?.profileImageURL ?? "")
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
                                        Text("834")
                                            .bold()
                                        Text("Followers")
                                    }
                                    VStack {
                                        Text("162")
                                            .bold()
                                        Text("Following")
                                    }
                                }
                                Spacer()
                            }
                            .padding([.bottom], 10)
                            HStack {
                                VStack(alignment:.leading) {
                                    if ((session.session?.username.isEmpty) == false) {
                                        Text(session.session?.username ?? "")
                                            .bold()
                                    }
                                    if ((session.session?.bio.isEmpty) == false) {
                                        Text("Digital goodies designer @pixsellz")
                                            .fontWeight(.light)
                                    }
                                }
                                Spacer()
                            }
                            Button {
                                
                            } label: {
                                Text("Edit Profile")
                                    .bold()
                                    .foregroundColor(.black)
                            }
                            .frame(width: geometry.size.width / 1.2, height: 40)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
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
                        }.padding(.vertical, 10)
                    }
                }
            }
        }
        .onAppear {
            ProfileService.getAllPostFromUser { posts in
                listPost = posts
            }
            print(listPost)
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

#Preview {
    ProfileView()
}
