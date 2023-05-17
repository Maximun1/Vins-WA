//
//  AboutView.swift
//  AppGoose
//
//  Created by Max Bezzabara on 5/10/23.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack {
            ZStack {
                Colors(colors: .yellow.opacity(0.8))
                aboutViewContent
            }
        }
    }
    
    @ViewBuilder
    var aboutViewContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                Text("Welcome to VINS-WA")
                    .lineLimit(2)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Your App Name is a versatile app that simplifies your daily tasks and enhances your productivity.")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                    .background(Color.black)
                    .padding(.horizontal, 30)
                
                Text("Key Features")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVStack(alignment: .leading, spacing: 10) {
                    FeatureView(icon: "person.fill", title: "User Authentication", description: "Sign in or sign up to access personalized features.")
                    FeatureView(icon: "lock.fill", title: "Password Recovery", description: "Easily recover your password if you forget it.")
                    FeatureView(icon: "square.grid.2x2.fill", title: "Data Storage", description: "Securely store your data with CoreData or iCloud.")
                    FeatureView(icon: "qrcode.viewfinder", title: "QR Code Scanner", description: "Effortlessly scan QR codes for quick access to information.")
                    FeatureView(icon: "photo.fill", title: "Image and VIN Sharing", description: "Send pictures and VINs to companies for seamless communication.")
                    FeatureView(icon: "building.fill", title: "Company Selection", description: "Select and interact with preferred companies.")
                    
                    Spacer()
                        .frame(minHeight: 0, maxHeight: .infinity)
                }
                
                Divider()
                    .background(Color.black)
                    .padding(.horizontal, 30)
                
                Text("Why Choose VINS-WA?")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 10) {
                    ReasonView(title: "Simplify Your Workflow", description: "Streamline your daily tasks and save time.")
                    ReasonView(title: "Data Security", description: "Your data is protected with advanced security measures.")
                    ReasonView(title: "Seamless Collaboration", description: "Effortlessly communicate and collaborate with companies.")
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .navigationBarTitle("About", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Home")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.red)
                    .cornerRadius(8)
            }
            )
        }
    }
    
}

struct FeatureView: View {
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 30, height: 30, alignment: .top)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
            }
        }
    }
}

struct ReasonView: View {
    var title: String
    var description: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "checkmark.circle.fill")
                .font(.title)
                .foregroundColor(.green)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2) // Set lineLimit to 2
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
        )
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
