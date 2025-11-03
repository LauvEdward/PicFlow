//
//  PostView+Styled.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import SwiftUI
import Photos

// MARK: - Original enums
enum StatePostView: String {
    case selectImage
    case upload
}

// MARK: - PostView (giữ nguyên logic, chỉ thêm style)
struct PostView: View {
    @EnvironmentObject private var photoLibraryService: PhotoLibraryService
    @State var asset: PHAsset?
    @State var description: String = ""
    @State var statePostView: StatePostView  = .selectImage
    @State private var loadState: LoadState = .success

    var body: some View {
        Group {
            switch loadState {
            case .loading:
                VStack(alignment: .center){
                    ProgressView()
                }
            case .success:
                viewUpload()
            case .failed:
                EmptyView()
            }
        }
    }
    
    func viewUpload() -> some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(pinnedViews: .sectionHeaders) {
                    Section {
                        VStack {
                            // Top bar
                            HStack(spacing: 12) {
                                Image(systemName: "xmark")
                                    .frostedCircleIcon()
                                    .onTapGesture {
                                        asset = nil
                                        statePostView = .selectImage
                                    }

                                Text("New Post")
                                    .bold()

                                Spacer()

                                Text(statePostView == .upload ? "Upload" : "Next")
                                    .primaryCapsule()
                                    .onTapGesture {
                                        if asset != nil {
                                            if statePostView == .selectImage {
                                                statePostView = .upload
                                            } else {
                                                self.loadState = .loading
                                                guard let asset = asset else { return }
                                                PostService.uploadPost(
                                                    imageData: asset.getAssetThumbnail().jpegData(compressionQuality: 0.7) ?? Data(),
                                                    caption: description
                                                ) {
                                                    // upload and reset screen
                                                    self.asset = nil
                                                    self.statePostView = .selectImage
                                                    self.loadState = .success
                                                } onError: { error in
                                                    print(error)
                                                    self.loadState = .failed
                                                }
                                            }
                                        }
                                    }
                            }
                            .padding(.top, 6)

                            Divider().opacity(0)

                            // Preview image / placeholder
                            Group {
                                if let asset {
                                    Image(uiImage: asset.getAssetThumbnail(targetSize: CGSize(width: geometry.size.width - 50, height: geometry.size.height/2.5)))
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    Image(systemName: "photo.on.rectangle.angled")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 120)
                                        .foregroundStyle(.secondary)
                                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height/2.5)
                                }
                            }
                            .frame(width: geometry.size.width - 50, height: geometry.size.height/2.5)
                            .clipShape(RoundedRectangle(cornerRadius: PFTheme.radius, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: PFTheme.radius, style: .continuous)
                                    .strokeBorder(Color.cardStroke, lineWidth: 1)
                            )
                            .overlay(alignment: .bottomLeading) {
                                LinearGradient(colors: [.black.opacity(0.0), .black.opacity(0.35)],
                                               startPoint: .top, endPoint: .bottom)
                                    .frame(height: 110)
                                    .clipShape(RoundedRectangle(cornerRadius: PFTheme.radius, style: .continuous))
                                    .overlay(
                                        Text("Preview")
                                            .font(.subheadline).bold()
                                            .foregroundStyle(.white.opacity(0.9))
                                            .padding(.horizontal, 12).padding(.bottom, 12),
                                        alignment: .bottomLeading
                                    )
                            }
                            .shadow(color: .shadow, radius: 16, x: 0, y: 8)

                            Divider().opacity(0)
                        }
                        .padding(.horizontal, 25)
                        .background(Color.appBG.ignoresSafeArea())
                    }
                    Section {
                        // Content
                        if statePostView == .upload {
                            VStack(alignment: .leading, spacing: 8) {
                                

                                TextEditor(text: $description)
                                    .frame(minHeight: 140, maxHeight: 200)
                                    .padding(10)
                                    .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12))
                                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.cardStroke, lineWidth: 1))
                                    .placeholder(description.isEmpty) {
                                        Text("Type here")
                                            .foregroundStyle(.secondary)
                                            .padding(.leading, 14)
                                            .padding(.top, 16)
                                    }

                                Text("\(description.count)/2200")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .pfCard()
                        } else {
                            PhotoLibraryView(phAssetSelect: $asset, photoLibraryService: photoLibraryService)
                        }
                    } header: {
                        if statePostView == .upload {
                            Text("Enter description")
                                .font(.subheadline).fontWeight(.semibold)
                        } else {
                            HStack {
                                Text("Select Photo")
                                    .bold()
                                    .font(.title3)
                                Spacer()
                            }
                            .padding(.bottom, 2)
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
    }
}
