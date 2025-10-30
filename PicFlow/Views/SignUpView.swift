//
//  SignInView.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/8/25.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordAgain: String = ""
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var profileImage: Image?
    @State private var pickedImage: Image?
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Environment(\.dismiss) var dismiss
    @State private var isSigningUp: Bool = false
    @State private var showAlert = false
    @State private var message: String? = ""
    @State var loginStatus: Bool = false
    
    func loadImage() {
        guard let inputImage = pickedImage else { return }
        profileImage = inputImage
    }
    
    func signUp() {
        isSigningUp = true
        if email.isEmpty || password.isEmpty || passwordAgain.isEmpty {
            return
        }
        AuthService.signUp(username: "", email: email, password: password, imageData: imageData) { user in
            print("Success")
            showAlert = true
            message = "Sign Up Success, Welcome to Picflow"
            isSigningUp = false
            loginStatus = true
        } onError: { errorMessage in
            showAlert = true
            message = errorMessage
            isSigningUp = false
            loginStatus = false
            print(errorMessage)
        }

    }
    
    var body: some View {
        GeometryReader { proxy in
            let availableWidth = proxy.size.width
            VStack {
                if isSigningUp {
                    ProgressView()
                } else {
                    Spacer()
                    VStack(alignment: .center, spacing: 20) {
                        Image("instagram_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: availableWidth / 2)
                        
                        VStack {
                            if profileImage != nil {
                                profileImage?
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(25)
                            } else {
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
                            signUp()
                        } label: {
                            Text("Sign Up")
                        }
                        .buttonStyle(PFButtonStyle(isEnable:!(email.isEmpty || password.isEmpty || password.isEmpty || (passwordAgain != password))))
                        .frame(maxWidth: availableWidth / 1.5)
                        .alert("SignUp Status", isPresented: $showAlert) {
                            Button("OK") {
                                showAlert = false
                                if loginStatus {
                                    dismiss()
                                }
                            }
                        } message: {
                            Text(message ?? "")
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
                            Text("Have an account?")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Login")
                                .subTextBlue()
                                .onTapGesture {
                                    dismiss()
                                }
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
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Select photo"), buttons: [
                    .default(Text("Choose a library"), action: {
                        self.sourceType = .photoLibrary
                        showImagePicker = true
                    }),
                    .default(Text("Take a photo"), action: {
                        self.sourceType = .camera
                        showImagePicker = true
                    }),
                    .cancel()
                ])
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(pickerImage: self.$pickedImage, showImagePicker: $showImagePicker, imageData: $imageData, sourceType: $sourceType)
            }
        }
    }
}

#Preview {
    SignUpView()
}
