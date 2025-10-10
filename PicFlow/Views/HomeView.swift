//
//  HomeView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionStore
    var body: some View {
        VStack {
//            Button {
//                session.logout()
//            } label: {
//                Text("Logout")
//            }
            CústomTabView()
        }
    }
}

#Preview {
    CústomTabView()
}

var tabs = ["house.fill", "magnifyingglass", "camera.viewfinder", "heart.fill", "person.fill"]

struct CústomTabView: View {
    @State var selectedTab = "house.fill"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab, content: {
                MainView()
                    .tag("house.fill")
                SearchView()
                    .tag("magnifyingglass")
                PostView()
                    .tag("camera.viewfinder")
                NotificationsView()
                    .tag( "heart.fill")
                ProfileView()
                    .tag("person.fill")
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
            HStack {
                ForEach(tabs, id: \.self) { image in
                    TabButton(image: image, selectedTab: $selectedTab)
                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(Color.white.opacity(0.9))
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
            .padding(.horizontal)
            .padding(.bottom, edge?.bottom == 0 ? 20 : 0)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color.black.opacity(0.05))
    }
}

struct TabButton: View {
    var image: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button {
            selectedTab = image
        } label: {
            Image(systemName: image)
        }
        .foregroundColor(selectedTab == image ? .blue : .gray)
        .padding()
    }
}
