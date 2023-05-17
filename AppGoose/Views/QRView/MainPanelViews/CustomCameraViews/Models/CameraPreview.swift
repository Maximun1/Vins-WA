//
//  CameraPreview.swift
//  AppGoose
//
//  Created by Max on 5/13/23.
//

import Foundation
import AVFoundation
import SwiftUI

struct CameraPreview: UIViewRepresentable {
    var camera: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: camera.session)
        previewLayer.frame = view.frame
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
