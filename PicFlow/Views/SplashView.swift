//
//  SplashView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var session: SessionStore
    var body: some View {
        if session.session != nil {
            HomeView()
        } else {
            SignInView()
        }
    }
}

#Preview {
    SplashView()
}
