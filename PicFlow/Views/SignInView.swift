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
    @State private var isSigningIn: Bool = false
    @State private var showAlert = false
    @State private var message: String? = ""
    @EnvironmentObject var session: SessionStore
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                let availableWidth = proxy.size.width
                VStack {
                    if isSigningIn {
                        ProgressView()
                    } else {
                        Spacer()
                        VStack(alignment: .center, spacing: 20) {
                            Image("instagram_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: availableWidth / 2)
                            
                            PFTextField(value: $email, placeholder: "Email", isSecureTextEntry: false)
                            
                            PFTextField(value: $password, placeholder: "Password", isSecureTextEntry: true)
                            
                            
                            HStack {
                                Spacer()
                                Text("Forgot password?")
                                    .subTextBlue()
                            }
                            
                            
                            Button {
                                isSigningIn = true
                                AuthService.signIn(email: email, password: password) { user in
                                    self.isSigningIn = false
                                    session.listen()
                                    print("Sign in Success")
                                } onError: { errorMessage in
                                    self.isSigningIn = false
                                    print(errorMessage)
                                    showAlert = true
                                    message = errorMessage
                                }
                                
                            } label: {
                                Text("Login")
                            }
                            .buttonStyle(PFButtonStyle(isEnable:!(email.isEmpty || password.isEmpty)))
                            .frame(maxWidth: availableWidth / 1.5)
                            .alert("Login Status", isPresented: $showAlert) {
                                Button("OK") {
                                    showAlert = false
                                }
                            } message: {
                                Text(message ?? "Login Fail")
                            }
                            
                            HStack {
                                Image("facebook_mini")
                                Text("Log in with Facebook")
                                    .subTextBlue()
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
                                NavigationLink(destination: SignUpView()) {
                                    Text("Sign up")
                                        .subTextBlue()
                                }
                            }
                        }.padding(.horizontal)
                        Spacer()
                        Divider()
                        Text("Instagram оr Facebook")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom)
                        
                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
    }
}

#Preview {
    SignInView()
}
