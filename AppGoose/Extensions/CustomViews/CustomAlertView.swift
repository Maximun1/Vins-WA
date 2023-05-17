//
//  CustomAlertView.swift
//  AppGoose
//
//  Created by Max Bezzabara on 5/10/23.
//

import SwiftUI

struct CustomAlertView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool
    @State var textField1: String = ""
    @State var textField2: String = ""
    
    @State var textFieldPlacerholder1: String
    @State var textFieldPlacerholder2: String
    
    var title: String
    var message: String
    
    var onConfirm: ((_ text1: String, _ text2: String) -> Void)?
    var onCancel: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                TextField("\(textFieldPlacerholder1)", text: $textField1)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .keyboardType(.default)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                TextField("\(textFieldPlacerholder2)", text: $textField2)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                HStack(spacing: 40) {
                    Button(action: {
                        withAnimation {
                            isPresented = false
                            onCancel?()
                        }
                    }) {
                        Text("Cancel")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        withAnimation {
                            isPresented = false
                            onConfirm?(textField1, textField2)
                        }
                    }) {
                        Text("Confirm")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(20)
        }
    }
}
