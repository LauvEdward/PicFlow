//
//  AddView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import SwiftUI
import Photos

struct PostView: View {
    @State var imagePost: Image?
    @State var imageDataPost: Data = Data()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var showImagePicker = true
    @State var asset: PHAsset?
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Image(systemName: "xmark")
                        .padding(.trailing, 25)
                    Text("New Post")
                        .bold()
                    Spacer()
                    Text("Next")
                        .foregroundColor(.blue)
                }
                Divider()
                if let asset {
                    Image(uiImage: asset.getAssetThumbnail(targetSize: CGSize(width: geometry.size.width - 50, height: geometry.size.height/2.5)))
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width - 50,height: geometry.size.height/2.5)
                        .clipped()
                } else {
                    Image("mockimage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width - 50, height: geometry.size.height/2.5)
                        .clipped()
                }
                Divider()
                HStack {
                    Text("Select Photo")
                        .bold()
                        .font(.title3)
                        .padding(.bottom, 10)
                    Spacer()
                }
                PhotoLibraryView(phAssetSelect: $asset)
            }
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    PostView()
}
