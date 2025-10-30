//
//  SwitchAccount.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/8/25.
//

import SwiftUI

struct SwitchAccount: View {
    var body: some View {
        GeometryReader { proxy in
            let availableWidth = proxy.size.width
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                Image("instagram_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: availableWidth / 2)
                Image("avatar")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: availableWidth / 4)
                    .cornerRadius(availableWidth / 8)
                Text("jacob_w")
                    .fontWeight(.semibold)
                
                Button {
                    
                } label: {
                    Text("Login")
                }
                .buttonStyle(PFButtonStyle(isEnable: true))
                .frame(maxWidth: availableWidth / 1.5)

                
                Text("Switch accounts")
                    .subTextBlue()
                Spacer()
                Divider()
                HStack {
                    Text("Don’t have an account?")
                        .font(Font.subheadline)
                        .foregroundColor(.gray)
                    Text("Sign up")
                        .font(Font.subheadline.bold())
                }
                .padding(.bottom)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

#Preview {
    SwitchAccount()
}
