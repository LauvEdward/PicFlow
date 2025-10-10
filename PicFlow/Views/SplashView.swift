//
//  SplashView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var session: SessionStore
    func listen() {
        session.listen()
    }
    
    var body: some View {
            Group {
                if session.loading {
                    ProgressView()
                } else {
                    if session.session != nil {
                        HomeView()
                    } else {
                        SignInView()
                    }
                }
            }.onAppear(perform: listen)
        }
}

#Preview {
    SplashView()
}
