//
//  ProfileView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var tabSelected: Int = 1
    @State private var listPost: [PostModel] = []
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
                                    Text("Edward lauv")
                                    Image(systemName: "chevron.down")
                                }
                                Spacer()
                                Image(systemName: "line.3.horizontal")
                            }
                            HStack {
                                Image("avatar")
                                Spacer()
                                HStack(spacing: 20) {
                                    VStack {
                                        Text("54")
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
                            HStack {
                                VStack(alignment:.leading) {
                                    Text("Edwardlauv")
                                        .bold()
                                    Text("Digital goodies designer @pixsellz")
                                        .fontWeight(.light)
                                    Text("Everything is designed.")
                                        .fontWeight(.light)
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
                                    AsyncImage(url: URL(string: post.imageUrl)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView() // Placeholder while loading
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        case .failure:
                                            Image(systemName: "exclamationmark.triangle.fill") // Error indicator
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
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
    }
}

#Preview {
    ProfileView()
}
