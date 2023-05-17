//
//  HelpView.swift
//  AppGoose
//
//  Created by Max Bezzabara on 5/10/23.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    helpViewContent
                }.background(Color.yellow.opacity(0.8).edgesIgnoringSafeArea(.all))
            }
        }
    }
    
    @ViewBuilder
    var helpViewContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Text("App Overview")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Group {
                    Text("1. Getting Started:")
                    Text("- Sign up or log in using your email address and password.")
                    Text("- Navigate to different sections of the app using the menu or icons.")
                    Text("- Interact with the app's features by following the on-screen instructions.")
                }
                
                Group {
                    Text("2. Features:")
                    Text("- User Authentication: Sign in or sign up to access personalized features.")
                    Text("- Password Recovery: Easily recover your password if you forget it.")
                    Text("- Data Storage: Securely store your data with CoreData or iCloud.")
                    Text("- QR Code Scanner: Effortlessly scan QR codes for quick access to information.")
                    Text("- Image and VIN Sharing: Send pictures and VINs to companies for seamless communication.")
                    Text("- Company Selection: Select and interact with preferred companies.")
                }
                
                Group {
                    Text("3. Common Errors and Troubleshooting:")
                    
                    Text("a. App not responding:")
                    Text("- Check your internet connection to ensure you're connected.")
                    Text("- Refresh the app or reload the page and try again.")
                    
                    Text("b. Unexpected behavior:")
                    Text("- Ensure you're using the latest version of the app.")
                    Text("- If the issue persists, try reinstalling the app or clearing the app's cache.")
                    
                    Text("c. Difficulty with features:")
                    Text("- Refer to the app's documentation or tutorials.")
                    Text("- Reach out to the support team for assistance.")
                }
                
                Group {
                    Text("4. Contact Support:")
                    Text("If you're facing technical difficulties or have specific inquiries about the app, reach out to the app's support team for assistance.")
                    Text("Email: max.bezzabara@gmail.com")
                    
                    Text("Remember that while this app strives to provide helpful and efficient features, it may not always be perfect. Please provide feedback and suggestions to help improve the app.")
                        .font(.caption)
                }
            }.foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
            .padding()
            .navigationBarTitle("Help", displayMode: .inline)
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
