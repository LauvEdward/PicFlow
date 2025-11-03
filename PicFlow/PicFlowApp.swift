//
//  PicFlowApp.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/8/25.
//

import SwiftUI
import FirebaseCore
import Photos

@main
struct PicFlowApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionStore = SessionStore()
    @StateObject var photoLibraryService = PhotoLibraryService()
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(sessionStore)
                .environmentObject(photoLibraryService)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
