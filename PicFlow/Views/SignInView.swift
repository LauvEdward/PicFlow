//
//  SignInView.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/8/25.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        GeometryReader { proxy in
            let availableWidth = proxy.size.width
            VStack {
                Spacer()
                VStack(alignment: .center, spacing: 20) {
                    Image("instagram_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: availableWidth / 2)
                    TextField("Email", text: $email) {
                        
                    }
                    .padding()
                    .font(.system(size: 14))
                    .frame( maxHeight: 40)
                    .cornerRadius(5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    }
                    .background(Color.gray.opacity(0.1))
                    TextField("Password", text: $password){
                        
                    }
                    .padding()
                    .font(.system(size: 14))
                    .frame( maxHeight: 40)
                    .cornerRadius(5)
                    .background(Color.gray.opacity(0.1))
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    }
                    
                    
                    HStack {
                        Spacer()
                        Text("Forgot password?")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Login")
                    }
                    .frame(maxWidth: availableWidth / 1.5, maxHeight: 40)
                    .foregroundColor(.white)
                    .background(email.isEmpty || password.isEmpty ? Color.blue.opacity(0.5) : Color.blue)
                    .cornerRadius(5)
                    
                    HStack {
                        Image("facebook_mini")
                        Text("Log in with Facebook")
                            .foregroundColor(.blue)
                            .fontWeight(.medium)
                    }
                    
                    HStack {
                        VStack {
                            Divider()
                        }
                        Text("OR")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        VStack {
                            Divider()
                        }
                    }
                    
                    HStack {
                        Text("Don’t have an account?")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Sign up")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                
                .padding(.horizontal)
                Spacer()
                Divider()
                Text("Instagram оr Facebook")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

#Preview {
    SignInView()
}
