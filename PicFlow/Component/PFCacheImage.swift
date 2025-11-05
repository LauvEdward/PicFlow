//
//  CacheImage.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 29/10/25.
//

import SwiftUI
import FirebaseStorage

struct PFCacheImage: View {
    private var url: String
    @State var image: UIImage? = nil
    @State private var loadState: LoadState = .loading
    init(url: String) {
        self.url = url
    }
    
    var body: some View {
        Group {
            switch loadState {
            case .loading:
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            case .failed:
                Image(systemName: "exclamationmark.triangle")
            case .success:
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image(systemName: "exclamationmark.triangle")
                }
            }
        }
    }
    
    private func loadImage() {
        // check cache first
        if let cached = ImageCache.shared.getImage(url as NSString) {
            self.image = cached
            self.loadState = .success
            return
        }
        
        guard let url = URL(string: url) else {
            self.loadState = .failed
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, res, err in
            if let err = err {
                print("❌ error downloading image: \(err)")
                DispatchQueue.main.async {
                    self.loadState = .failed
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.loadState = .failed
                }
                return
            }
            
            ImageCache.shared.setImage(image, forkey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                self.image = image
                self.loadState = .success
            }
        }.resume()
    }
    
}

class ImageCache {
    static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    func getImage(_ key: NSString) -> UIImage? {
        return cache.object(forKey: key)
    }
    
    func setImage(_ image: UIImage, forkey key: NSString) {
        cache.setObject(image, forKey: key)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
