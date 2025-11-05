<img width="1920" height="1080" alt="screenshot" src="https://github.com/user-attachments/assets/991eab78-a89a-41a4-803a-55fcf88680f7" />

PicFlow — Instagram clone (SwiftUI)
===================================

Ứng dụng mẫu “clone Instagram” viết bằng **SwiftUI**.

Tính năng
---------

*   Đăng ký / Đăng nhập (Firebase Auth)
    
*   Đăng ảnh (Photo Library → Storage)
    
*   Like / Comment (Firestore)
    
*   Profile cá nhân (avatar, username, grid ảnh)
    
*   Tìm kiếm ảnh
    
*   Notification (thông báo like/comment trong app)
    

Yêu cầu
-------

*   Xcode 15+ · iOS 16+
    
*   Tạo **Firebase Project**
    
*   Thêm file **GoogleService-Info.plist** vào target iOS

Cài đặt Firebase (ngắn gọn)
---------------------------

1.  Vào \[Firebase Console\] → **Add project**.
    
2.  Thêm app iOS (bundle id khớp với dự án), tải **GoogleService-Info.plist** và kéo vào Xcode (Target Membership bật ON).
    
3.  **SPM**: Xcode → File > Add Packages…Thêm https://github.com/firebase/firebase-ios-sdk (dùng SPM sẽ giúp build nhanh hơn thay vì cocoapods) và chọn:
    
    *   FirebaseAuth
        
    *   FirebaseFirestore
        
    *   FirebaseStorage
