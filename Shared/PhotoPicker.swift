//
//  PhotoPicker.swift
//  iOS
//
//  Created by Bernd on 26.11.21.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @ObservedObject var model: Model
    @Binding var showPhotoPicker: Bool
  
  func makeUIViewController(context: Context) -> some UIViewController {
    var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
    configuration.filter = .images // filter only to images
    configuration.selectionLimit = 1 // ignore limit
    
    let photoPickerViewController = PHPickerViewController(configuration: configuration)
    photoPickerViewController.delegate = context.coordinator
    return photoPickerViewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: PHPickerViewControllerDelegate {
    private let parent: PhotoPicker
    
    init(_ parent: PhotoPicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        //picker.dismiss(animated: true, completion: nil)
        parent.showPhotoPicker = false

        // Only 1 image can be selected, so ignore any additional elements.
        guard let result = results.first else {
            return
        }
        
        print("\(result.assetIdentifier!)")// = result.assetIdentifier
        
        if let assetId = result.assetIdentifier {
                       let assetResults = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil)
                       DispatchQueue.main.async {
                           let firstAsset = assetResults.firstObject
                               print(self.parent.model.foodItems.count)
                               self.parent.model.insertFood(foodItems: [Food(assetID: firstAsset!.localIdentifier, createDate: firstAsset!.creationDate!)])
                           //}
                       }
                   }
        
//        if let assetId = results.first?.assetIdentifier,
//                   let asset = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil).firstObject
//                {
//                    print("asset is \(asset)")
//                    parent.model.insertFood(food: Food(assetID: asset.localIdentifier, createDate: asset.creationDate!))
//
//                    PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil, resultHandler: { (image, info) in
//                        print("requested image is \(image)")
//                    })
//                }
        
        
    }
  }
}
