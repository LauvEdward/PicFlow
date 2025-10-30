//
//  PFTextField.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/8/25.
//

import SwiftUI

struct PFTextField: View {
    @Binding var value: String
    var placeholder: String = ""
    @State var isSecureTextEntry: Bool = true
    @State var isShow = false
    
    var body: some View {
        VStack {
            if isSecureTextEntry {
                HStack {
                    if !isShow {
                        SecureField(placeholder, text: $value) {
                            
                        }
                        .textContentType(.none)
                    } else {
                        TextField(placeholder, text: $value)
                    }
                    Button {
                        self.isShow.toggle()
                    } label: {
                        Image(systemName: self.isShow ? "eye.slash" : "eye")
                            .accentColor(.gray)
                    }
                }
            } else {
                TextField(placeholder, text: $value)
            }
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
        
    }
}

#Preview {
    PFTextField(value: .constant(""), placeholder: "Password")
}
