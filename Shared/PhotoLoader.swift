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
        // 1
        let fetchOptions = PHFetchOptions()
        // 2
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return fetchOptions
    }
    
    private func requestOptions() -> PHImageRequestOptions {
        let requestOptions = PHImageRequestOptions()
        // 2
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .opportunistic
        //options.resizeMode = PHImageRequestOptionsResizeMode.Exact
        return requestOptions
    }
    
    public func loadImage(assetIdentifier:String) -> UIImage? {
        let manager = PHImageManager.default()
        //let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions())
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(withLocalIdentifiers: [assetIdentifier], options: fetchOptions())

        // 1
        var image: UIImage? = nil
        // 2
        manager.requestImage(for: fetchResult.object(at: 0), targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: requestOptions()) { img, err  in
            // 3
            guard let img = img else { return }
                image = img
        }
        return image
    }
}
