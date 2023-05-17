//
//  CameraModel.swift
//  AppGoose
//
//  Created by Max on 5/13/23.
//

import SwiftUI
import Foundation
import AVFoundation
import Photos

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var session = AVCaptureSession()
    @Published var isAuthorized = false
    @Published var isSessionRunning = false
    
     let sessionQueue = DispatchQueue(label: "sessionQueue")
     var capturePhotoOutput = AVCapturePhotoOutput()
     var videoDeviceInput: AVCaptureDeviceInput!
     var photoCaptureCompletionBlock: ((UIImage?) -> Void)?
    
    func checkAuthorizationStatus() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isAuthorized = true
        case .notDetermined:
            requestCameraAccess()
        default:
            isAuthorized = false
        }
    }
    
    func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                self.isAuthorized = granted
            }
        }
    }
    
    func configureSession() {
        guard isAuthorized else { return }
        
        session.beginConfiguration()
        
        // Setup video input
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified) else {
            print("Unable to get video device")
            session.commitConfiguration()
            return
        }
        
        do {
            videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
        } catch {
            print("Unable to create video device input: \(error)")
            session.commitConfiguration()
            return
        }
        
        if session.canAddInput(videoDeviceInput) {
            session.addInput(videoDeviceInput)
        } else {
            print("Unable to add video device input to the session")
            session.commitConfiguration()
            return
        }
        
        // Setup photo output
        if session.canAddOutput(photoOutput) {
            session.addOutput(capturePhotoOutput)
        } else {
            print("Unable to add photo output to the session")
            session.commitConfiguration()
            return
        }
        
        session.commitConfiguration()
        
        // Start session
        sessionQueue.async {
            self.session.startRunning()
            DispatchQueue.main.async {
                self.isSessionRunning = self.session.isRunning
            }
        }
    }
    
     let photoOutput = AVCapturePhotoOutput()
    
    func takePhoto(completion: @escaping (UIImage?) -> Void) {
        let photoSettings = AVCapturePhotoSettings()
        
        // Check if high-resolution photo capture is supported before enabling it
        photoSettings.maxPhotoDimensions = capturePhotoOutput.maxPhotoDimensions
        
        sessionQueue.async {
            self.capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
            self.photoCaptureCompletionBlock = completion  // Store the completion block for later use
        }
    }
    
    // AVCapturePhotoCaptureDelegate method
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            photoCaptureCompletionBlock?(nil)
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else {
            print("Unable to get image data")
            photoCaptureCompletionBlock?(nil)
            return
        }
        
        let image = UIImage(data: imageData)
        saveImageToPhotoLibrary(image: image!) { result in
            switch result {
            case .success:
                print("Image saved to photo library")
            case .failure(let error):
                print("Error saving image to photo library: \(error)")
            }
        }
        DispatchQueue.main.async {
            self.photoCaptureCompletionBlock?(image)
        }
    }
    
    
    func saveImageToPhotoLibrary(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void) {
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetCreationRequest.forAsset()
            creationRequest.addResource(with: .photo, data: image.jpegData(compressionQuality: 1.0)!, options: nil)
        }, completionHandler: { success, error in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        })
    }
}
