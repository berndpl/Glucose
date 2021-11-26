//
//  DocumentPicker.swift
//  iOS
//
//  Created by Bernd on 26.11.21.
//

import SwiftUI

struct DocumentPicker:UIViewControllerRepresentable {
    @ObservedObject var model: Model
    @Binding var fileContent:String
    
    var delegate:UIDocumentPickerDelegate?
    
    func makeCoordinator() -> DocumentPickerCoordinator {
        return DocumentPickerCoordinator(fileContent: $fileContent, model:model)
    }
    
    func makeUIViewController(context: Context) -> some UIDocumentPickerViewController {
        let controller:UIDocumentPickerViewController = UIDocumentPickerViewController (forOpeningContentTypes: [.text], asCopy: true)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

class DocumentPickerCoordinator:NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
    
    @ObservedObject var model: Model
    
    @Binding var fileContent:String
    
    init(fileContent:Binding<String>, model:Model) {
        _fileContent = fileContent
        self.model = model
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let fileURL = urls[0]
        do {
            fileContent = try String(contentsOf: fileURL, encoding: .utf8)
            model.didReadFile(content: fileContent)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
