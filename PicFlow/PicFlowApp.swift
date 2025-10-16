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
    @StateObject var photoLibraryService = PhotoLibraryService()
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(SessionStore())
//            PhotoLibraryView(phAssetSelect: $phasset)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
