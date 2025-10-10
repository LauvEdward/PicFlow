//
//  PHAsset.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 12/10/25.
//

import Foundation
import Photos
import UIKit
extension PHAsset {
    func getAssetThumbnail(targetSize: CGSize) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: self, targetSize: targetSize, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            guard let result = result else { return }
            thumbnail = result
        })
        return thumbnail
    }
}
