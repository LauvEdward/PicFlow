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
    @State var phasset: PHAsset?
    @StateObject var sessionStore = SessionStore()
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(sessionStore)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
