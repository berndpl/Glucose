//
//  PhotoLoader.swift
//  iOS
//
//  Created by Bernd on 27.11.21.
//

import Foundation
import PhotosUI
import SwiftUI




struct PhotoLoader {
    
    private func fetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return fetchOptions
    }
    
    private func requestOptions() -> PHImageRequestOptions {
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .opportunistic
        return requestOptions
    }
    
    public func loadImage(assetIdentifier:String) -> UIImage? {
        let manager = PHImageManager.default()
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(withLocalIdentifiers: [assetIdentifier], options: fetchOptions())
        var image: UIImage? = nil
        manager.requestImage(for: fetchResult.object(at: 0), targetSize: CGSize(width: 220, height: 220), contentMode: .aspectFill, options: requestOptions()) { img, err  in
            guard let img = img else { return }
                image = img
        }
        return image
    }
}
