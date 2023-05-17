//
//  ImagePickerView.swift
//  AppGoose
//
//  Created by Max on 5/13/23.
//

import Foundation
import SwiftUI
import PhotosUI

struct ImagePickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var selectedImagesManager: SelectedImagesManager
    var sourceType: UIImagePickerController.SourceType
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var presentationMode: PresentationMode
        @ObservedObject var selectedImagesManager: SelectedImagesManager
        var sourceType: UIImagePickerController.SourceType
        
        init(presentationMode: Binding<PresentationMode>, selectedImagesManager: ObservedObject<SelectedImagesManager>, sourceType: UIImagePickerController.SourceType) {
            _presentationMode = presentationMode
            _selectedImagesManager = selectedImagesManager
            self.sourceType = sourceType
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            presentationMode.dismiss()
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self?.selectedImagesManager.selectedImages.append(image)
                            }
                        }
                    }
                }
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                DispatchQueue.main.async {
                    self.selectedImagesManager.selectedImages.append(image)
                }
            }
            presentationMode.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, selectedImagesManager: _selectedImagesManager, sourceType: sourceType)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIViewController {
        if sourceType == .photoLibrary {
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = Int.max
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = context.coordinator
            return picker
        } else {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = context.coordinator
            return picker
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ImagePickerView>) {}
}
