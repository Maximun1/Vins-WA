//
//  RectangleViews.swift
//  AppGoose
//
//  Created by Max Bezzabara on 5/10/23.
//

import SwiftUI

struct RectangleViews: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title: String
    @State var icon: String
    @State var description: String
    @Binding var presentView: Bool
    @EnvironmentObject var indexGr: IndexGrabber
    @State var index: Int
    
    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .cornerRadius(12)
                .overlay {
                    Button {
                        indexGr.index = index
                        if title != "Compose Email" {
                            presentView = true
                        }
                    } label: {
                        VStack {
                            Text("\(title)")
                                .foregroundColor(.black)
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            
                            if icon == "qrcode" || icon == "building.2.fill" || icon == "gearshape.fill" {
                                Image(systemName: icon)
                                    .foregroundColor(.black)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            } else {
                                Image(systemName: icon)
                                    .symbolRenderingMode(.multicolor)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 2))
                    }
                    .contentShape(RoundedRectangle(cornerRadius: 12))
                }
        }
    }
}

struct CompanyRectangleViews: View {
    @State var name: String
    @State var email: String
    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .cornerRadius(12)
                .overlay {
                    Button {
                        
                    } label: {
                        VStack {
                            HStack {
                                Text("\(name)")
                                    .foregroundColor(.black)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                            }
                            Text("\(email)")
                                .foregroundColor(.black)
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 2))
                    }
                    .contentShape(RoundedRectangle(cornerRadius: 12))
                }
        }
    }
}

struct FinalSelectionViewsRectangles: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title: String
    @State var icon: String
    @State var description: String
    @Binding var presentView: Bool
    @EnvironmentObject var selectedImagesManager: SelectedImagesManager
    
    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .cornerRadius(12)
                .overlay {
                    Button {
                        if title != "Compose Email" || selectedImagesManager.selectedImages.count >= 1 {
                            presentView.toggle()
                        }
                    } label: {
                        VStack {
                            Text("\(title)")
                                .foregroundColor(.black)
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            
                            if icon == "qrcode" || icon == "building.2.fill" || icon == "gearshape.fill" {
                                Image(systemName: icon)
                                    .foregroundColor(.black)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            } else {
                                Image(systemName: icon)
                                    .symbolRenderingMode(.multicolor)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 2))
                    }
                    .contentShape(RoundedRectangle(cornerRadius: 12))
                    .disabled(title == "Compose Email" && selectedImagesManager.selectedImages.count < 1)
                }
        }
    }
}
