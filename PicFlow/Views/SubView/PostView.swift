//
//  AddView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import SwiftUI
import Photos

enum StatePostView: String {
    case selectImage
    case upload
}

struct PostView: View {
    @State var asset: PHAsset?
    @State var description: String = ""
    @ObservedObject var photoLibraryService: PhotoLibraryService
    @State var statePostView: StatePostView  = .selectImage
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Image(systemName: "xmark")
                        .padding(.trailing, 25)
                        .onTapGesture {
                            asset = nil
                            statePostView = .selectImage
                        }
                    Text("New Post")
                        .bold()
                    Spacer()
                    Text(statePostView == .upload ? "Upload": "Next")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            if asset != nil {
                                if statePostView == .selectImage {
                                    statePostView = .upload
                                } else {
                                    
                                    guard let asset = asset else { return }
                                    PostService.uploadPost(imageData: asset.getAssetThumbnail().jpegData(compressionQuality: 0.7) ?? Data(), caption: description) {
                                        // upload and reset screen
                                        self.asset = nil
                                        self.statePostView = .selectImage
                                    } onError: { error in
                                        print(error)
                                    }


                                }
                            }
                        }
                }
                Divider()
                if let asset {
                    Image(uiImage: asset.getAssetThumbnail(targetSize: CGSize(width: geometry.size.width - 50, height: geometry.size.height/2.5)))
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width - 50,height: geometry.size.height/2.5)
                        .clipped()
                        .cornerRadius(10)
                } else {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width - 50, height: geometry.size.height/2.5)
                        .shadow(color: Color.black.opacity(0.2) ,radius: 10, x: 5, y: 5)
                        .clipped()
                        .cornerRadius(10)
                }
                Divider()
                if statePostView == .upload {
                    VStack(alignment: .leading) {
                        Text("Enter description:")
                            .fontWeight(.bold)
                        TextEditor(text: $description)
                            .cornerRadius(10)
                            .overlay {
                                if description.isEmpty {
                                    VStack {
                                        HStack {
                                            Text("Type here")
                                                .foregroundStyle(Color.secondary)
                                                .padding(4)
                                                .padding(.top, 4)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    .allowsHitTesting(false)
                                }
                            }
                    }.padding(.horizontal, -15)
                } else {
                    HStack {
                        Text("Select Photo")
                            .bold()
                            .font(.title3)
                            .padding(.bottom, 10)
                        Spacer()
                    }
                    .padding(.horizontal, -10)
                    PhotoLibraryView(phAssetSelect: $asset, photoLibraryService: photoLibraryService)
                        .padding(.horizontal, -20)
                }
            }
            .padding(.horizontal, 25)
        }
    }
}

