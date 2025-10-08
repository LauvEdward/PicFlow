//
//  SignInView.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/8/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordAgain: String = ""
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    
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
                    
                    VStack {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 50)
                            .cornerRadius(25)
                            .padding(25)
                            .overlay {
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.gray)
                            }
                        Text("Avatar")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        showActionSheet = true
                    }
                    
                    
                    PFTextField(value: $email, placeholder: "Email", isSecureTextEntry: false)
                    PFTextField(value: $password, placeholder: "Password", isSecureTextEntry: true)
                    PFTextField(value: $passwordAgain, placeholder: "Password-Again", isSecureTextEntry: true)
                    
                    HStack {
                        Spacer()
                        Text("Forgot password?")
                            .subTextBlue()
                    }
                    Button {
                        
                    } label: {
                        Text("Sign Up")
                    }
                    .buttonStyle(PFButtonStyle(isEnable:!(email.isEmpty || password.isEmpty || password.isEmpty || (passwordAgain != password))))
                    .frame(maxWidth: availableWidth / 1.5)
                    
                    
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
                        Text("Have an account?")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Login")
                            .subTextBlue()
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
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Select photo"), buttons: [
                    .default(Text("Choose a library"), action: {
                        
                    }),
                    .default(Text("Take a photo"), action: {
                        
                    }),
                    .cancel()
                ])
            }
        }
    }
}

#Preview {
    SignUpView()
}
