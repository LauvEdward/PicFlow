//
//  CachedAsyncImage.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/21/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    @State var cacheImage: UIImage?
    
    var body: some View {
        if cacheImage != nil {
//            Image(uiImage: cacheImage)
        } else {
            
        }
    }
}

#Preview {
    CachedAsyncImage()
}
