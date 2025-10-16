//
//  PhotoLibraryView.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 12/10/25.
//

import SwiftUI
import Photos

struct PhotoLibraryView: View {
    @Binding var phAssetSelect: PHAsset?
    @ObservedObject var photoLibraryService: PhotoLibraryService
    let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 4)
    var body: some View {
        GeometryReader { geometry in
            let w = (geometry.size.width - 2*2 - 3*2)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(photoLibraryService.list, id: \.self) { phasset in
                        AssetCell(asset: phasset, size: CGFloat(w/4), selectImage: $phAssetSelect)
                            .cornerRadius(5)
                    }
                }
            }
        }
    }
}

struct AssetCell: View {
    var asset: PHAsset
    var size: CGFloat
    @Binding var selectImage: PHAsset?
    @State private var image: UIImage?
    var body: some View {
        ZStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                if selectImage?.localIdentifier == asset.localIdentifier {
                    ZStack {
                        Rectangle()
                            .fill(.gray.opacity(0.5))
                            .frame(width: size, height: size)
                        Image(systemName: "checkmark.circle.fill")
                            .padding(.trailing, 0)
                            .padding(.top, 0)
                            .foregroundColor(.blue)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onTapGesture {
            selectImage = asset
        }
        .frame(width: size, height: size)
        .clipped()
        .onAppear { loadThumbnail() }
    }
    
    func loadThumbnail() {
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        options.isSynchronous = false
        let target = CGSize(width: size * UIScreen.main.scale,
                            height: size * UIScreen.main.scale)
        PHCachingImageManager.default().requestImage(
            for: asset,
            targetSize: target,
            contentMode: .aspectFill,
            options: options
        ) { img, _ in
            self.image = img
        }
    }
}
