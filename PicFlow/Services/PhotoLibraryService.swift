//
//  PhotoLibraryService.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 12/10/25.
//

import Foundation
import Photos
import Combine
import UIKit

class PhotoLibraryService: ObservableObject {
    @Published var list:[PHAsset] = []
    func requestAuthorization(completion: @escaping (String) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized, .limited:
                self.fetchAllPhoto()
                
            case .denied, .notDetermined, .restricted:
                completion("Can not access photo library")
            @unknown default:
                break
            }
        }
    }
    
    func fetchAllPhoto() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.includeHiddenAssets = false
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let result = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        DispatchQueue.main.async {
            result.enumerateObjects { (asset, _, _) in
                self.list.append(asset)
            }
        }
        
    }
}
