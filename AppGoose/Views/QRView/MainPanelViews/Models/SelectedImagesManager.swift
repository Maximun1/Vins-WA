//
//  SelectedImagesManager.swift
//  AppGoose
//
//  Created by Max on 5/13/23.
//

import Foundation
import SwiftUI
import PhotosUI
import AVFoundation
import Photos

class SelectedImagesManager: ObservableObject {
    @Published var selectedImages: [UIImage] = []
}
