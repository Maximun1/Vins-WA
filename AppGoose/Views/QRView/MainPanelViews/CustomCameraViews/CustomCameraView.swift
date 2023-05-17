//
//  CustomCameraView.swift
//  AppGoose
//
//  Created by Max on 5/13/23.
//

import SwiftUI

struct CustomCameraView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var selectedImagesManager: SelectedImagesManager
    @StateObject var camera = CameraModel()
    
    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Spacer()
                
                HStack {
                    Button(action: {
                        camera.takePhoto { image in
                            if let image = image {
                                selectedImagesManager.selectedImages.append(image)
                            }
                        }
                    }) {
                        Image(systemName: "camera")
                            .font(.system(size: 65))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom)
                    
                    Spacer()
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
        }
        .onAppear(perform: {
            camera.checkAuthorizationStatus()
            camera.configureSession()
        })
        .onDisappear(perform: {
            camera.session.stopRunning()
        })
    }
}
