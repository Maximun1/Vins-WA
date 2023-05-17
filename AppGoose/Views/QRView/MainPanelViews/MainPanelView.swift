//
//  MainPanelView.swift
//  AppGoose
//
//  Created by Max on 5/12/23.
//

import SwiftUI
import PhotosUI
import AVFoundation
import Photos
import ProgressHUD

struct MainPanelView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var selectedImagesManager = SelectedImagesManager()
    @State var isShowingImagePicker = false
    @State var isShowingCamera = false
    @State var isShowingEmailingPhotosView = false
    @State var isShowingSelectingCompaniesView = false
    @State var email: String
    @State var vin: String
    @EnvironmentObject var thisTx: thisTest
    @EnvironmentObject var indexGr: IndexGrabber
    
    @State var showTypeAlert: Bool = false
    @State var test: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.8), Color.yellow]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                    }
                    
                    VStack(spacing: 30) {
                        FinalSelectionViewsRectangles(title: "Select Photos", icon: "photo", description: "", presentView: $isShowingImagePicker)
                            .environmentObject(selectedImagesManager)
                            .onTapGesture {
                                isShowingImagePicker = true
                            }
                            .sheet(isPresented: $isShowingImagePicker) {
                                ImagePickerView(selectedImagesManager: selectedImagesManager, sourceType: .photoLibrary)
                            }
                        
                        FinalSelectionViewsRectangles(title: "Take Photos", icon: "camera", description: "", presentView: $isShowingCamera)
                            .environmentObject(selectedImagesManager)
                            .onTapGesture {
                                isShowingCamera = true
                            }
                            .fullScreenCover(isPresented: $isShowingCamera) {
                                CustomCameraView(selectedImagesManager: selectedImagesManager)
                                    .environmentObject(indexGr)
                            }
                        
                        ZStack {
                            FinalSelectionViewsRectangles(title: "Compose Email", icon: "envelope", description: "", presentView: $test)
                                .environmentObject(selectedImagesManager)
                            
                            Color.clear
                                .contentShape(Rectangle())
                        }
                        .onTapGesture {
                            if selectedImagesManager.selectedImages.count != 0 {
                                print("\(selectedImagesManager.selectedImages.count) <- A GOOSE")
                                showTypeAlert = true
                            } else {
                                ProgressHUD.showFailed("Please select or take some images to continue.")
                            }
                        }
                        .sheet(isPresented: $isShowingEmailingPhotosView) {
                            EmailingPhotosView(isShowingEmailingPhotosView: $isShowingEmailingPhotosView, selectedImages: selectedImagesManager.selectedImages, email: thisTx.getEmail, vin: thisTx.vin, companyType: thisTx.companyType)
                        }
                    }
                    Spacer()
                        .alert("Alert", isPresented: $showTypeAlert) {
                            Button("Pickup", role: .destructive) {
                                thisTx.companyType = "Pickup"
                                isShowingEmailingPhotosView.toggle()
                            }
                            Button("Delivery", role: .destructive) {
                                thisTx.companyType = "Delivery"
                                isShowingEmailingPhotosView.toggle()
                            }
                            Button("Cancel", role: .cancel) {
                                thisTx.companyType = ""
                                isShowingEmailingPhotosView = false
                            }
                        } message: {
                            Text("Please Select Pickup Or Delivery")
                        }
                }
                .padding()
            }.navigationBarItems(
                leading:
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Selecting Companies")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.red)
                            .cornerRadius(8)
                    })
            .navigationBarTitle("Selection", displayMode: .inline)
        }
    }
}
