//
//  NotificationsView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import SwiftUI

struct NotificationsView: View {
    @StateObject var notificationsService: NotificationService = NotificationService()
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            Text("Notifications")
                .bold()
                .font(.title)
            Divider()
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(notificationsService.listNotification, id: \.id) { noti in
                        HStack {
                            PFCacheImage(url: noti.image)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                            HStack {
                                Text("\(noti.name)")
                                    .bold()
                                if noti.isLike {
                                    Text("liked your photo ❤️")
                                }
                                if noti.iscomment {
                                    Text("commented your post")
                                }
                                if noti.isFollow {
                                    Text("started following you 👋")
                                }
                            }
                            Spacer()
                            if !noti.isFollow {
                                PFCacheImage(url: noti.postImage)
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .task {
            notificationsService.fetchNotification(userId: session.session?.uid ?? "")
        }
    }
}

