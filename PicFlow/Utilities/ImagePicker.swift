//
//  ImagePicker.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 8/10/25.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var pickerImage: Image?
    @Binding var showImagePicker: Bool
    @Binding var imageData: Data
    @Binding var sourceType: UIImagePickerController.SourceType
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
            
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            let uiImage = image
            parent.pickerImage = Image(uiImage: uiImage)
            if let data = uiImage.jpegData(compressionQuality: 0.5) {
                parent.imageData = data
            }
            parent.showImagePicker = false
        }
    }
}
