//
//  NotificationsView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import SwiftUI

struct NotificationsView: View {
    var listNotification: [NotificationModel] = []
    
    var body: some View {
        VStack {
            Text("Notifications")
                .bold()
                .font(.title)
            Divider()
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(listNotification, id: \.id) { noti in
                        HStack {
                            PFCacheImage(url: noti.image)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                            HStack {
                                Text("\(noti.name)")
                                    .bold()
                                Text(noti.isLike ? "liked your post" : "commented your post")
                            }
                            Spacer()
                            PFCacheImage(url: noti.postImage)
                                .frame(width: 40, height: 40)
                                .cornerRadius(5)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    let mockNotifications: [NotificationModel] = [
            NotificationModel(
                isLike: true,
                name: "phuc.le",
                date: Date().addingTimeInterval(-60 * 3), // 3 phút trước
                image: "https://randomuser.me/api/portraits/men/1.jpg",
                postId: "post001",
                userId: "user001",
                postImage: "https://picsum.photos/id/1005/400/400"
            ),
            NotificationModel(
                isLike: false,
                name: "loan.nguyen",
                date: Date().addingTimeInterval(-60 * 15),
                image: "https://randomuser.me/api/portraits/women/2.jpg",
                postId: "post002",
                userId: "user002",
                postImage: "https://picsum.photos/id/1011/400/400"
            ),
            NotificationModel(
                isLike: true,
                name: "john.tran",
                date: Date().addingTimeInterval(-60 * 45),
                image: "https://randomuser.me/api/portraits/men/3.jpg",
                postId: "post003",
                userId: "user003",
                postImage: "https://picsum.photos/id/1021/400/400"
            ),
            NotificationModel(
                isLike: false,
                name: "naomi.sato",
                date: Date().addingTimeInterval(-60 * 120),
                image: "https://randomuser.me/api/portraits/women/4.jpg",
                postId: "post004",
                userId: "user004",
                postImage: "https://picsum.photos/id/1032/400/400"
            ),
            NotificationModel(
                isLike: true,
                name: "takahiro.kimura",
                date: Date().addingTimeInterval(-60 * 240),
                image: "https://randomuser.me/api/portraits/men/5.jpg",
                postId: "post005",
                userId: "user005",
                postImage: "https://picsum.photos/id/1043/400/400"
            ),
            NotificationModel(
                isLike: false,
                name: "anh.pham",
                date: Date().addingTimeInterval(-60 * 480),
                image: "https://randomuser.me/api/portraits/women/6.jpg",
                postId: "post006",
                userId: "user006",
                postImage: "https://picsum.photos/id/1054/400/400"
            ),
            NotificationModel(
                isLike: true,
                name: "daisuke.tanaka",
                date: Date().addingTimeInterval(-60 * 720),
                image: "https://randomuser.me/api/portraits/men/7.jpg",
                postId: "post007",
                userId: "user007",
                postImage: "https://picsum.photos/id/1065/400/400"
            ),
            NotificationModel(
                isLike: false,
                name: "hana.lee",
                date: Date().addingTimeInterval(-60 * 1440),
                image: "https://randomuser.me/api/portraits/women/8.jpg",
                postId: "post008",
                userId: "user008",
                postImage: "https://picsum.photos/id/1076/400/400"
            ),
            NotificationModel(
                isLike: true,
                name: "minh.ngo",
                date: Date().addingTimeInterval(-60 * 2880),
                image: "https://randomuser.me/api/portraits/men/9.jpg",
                postId: "post009",
                userId: "user009",
                postImage: "https://picsum.photos/id/1087/400/400"
            ),
            NotificationModel(
                isLike: false,
                name: "ayaka",
                date: Date().addingTimeInterval(-60 * 4320),
                image: "https://randomuser.me/api/portraits/women/10.jpg",
                postId: "post010",
                userId: "user010",
                postImage: "https://picsum.photos/id/1098/400/400"
            )
    ]
    NotificationsView(listNotification: mockNotifications)
}
