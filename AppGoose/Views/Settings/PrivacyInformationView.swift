//
//  CloudKitPrivacyView.swift
//  AppGoose
//
//  Created by Max Bezzabara on 5/11/23.
//

import SwiftUI
import SafariServices

struct PrivacyInformationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Group {
                            Text("Privacy Information")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.top, 20)
                            
                            Text("Our app respects your privacy and is designed to ensure the security of your personal information.")
                                .font(.headline)
                                .padding(.top, 10)
                            
                            Text("Information Collection")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top, 10)
                            
                            Text("Our app does not collect, store, or share any personal information. All data used by the app is stored locally on your device using CoreData and synced with your iCloud account using CloudKit. No information is shared with third parties or stored on external servers.")
                                .padding(.top, 10)
                            
                            Text("Data Security")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top, 10)
                        }
                        
                        Text("We prioritize the security of your data. The data stored locally on your device using CoreData is encrypted and protected using industry-standard security measures. Additionally, CloudKit utilizes robust security protocols to ensure the safety of your data during synchronization with your iCloud account.")
                            .padding(.top, 10)
                        
                        Text("Third-Party Services")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Text("Our app may integrate with third-party services or APIs for enhanced functionality. However, these services will only be used in accordance with their respective privacy policies. Please review the privacy policies of any third-party services we may integrate with for more information.")
                            .padding(.top, 10)
                        
                        Text("Apple Privacy Policy")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Text("Apple manages your data in iCloud, and their privacy policy applies to the data stored in CloudKit. You can review Apple's privacy policy at:")
                            .padding(.top, 10)
                        
                        Button(action: {
                            guard let url = URL(string: "https://www.apple.com/legal/privacy/") else { return }
                            let safariViewController = SFSafariViewController(url: url)
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let mainWindow = windowScene.windows.first {
                                mainWindow.rootViewController?.present(safariViewController, animated: true, completion: nil)
                            }
                        }) {
                            Text("https://www.apple.com/legal/privacy/")
                                .foregroundColor(.blue)
                        }
                        .padding(.top, 5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }.background(Colors(colors: .yellow.opacity(0.8)).ignoresSafeArea())
                .navigationBarTitle("Privacy Information", displayMode: .inline)
                .navigationBarItems(leading:
                                        Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Settings")
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
}

struct PrivacyInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyInformationView()
    }
}
/*

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Privacy Policy")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Effective Date: [Date]")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("1. Data Collection")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("1.1 Core Data")
                Text("Our Service utilizes Core Data technology...")
                
                Text("1.2 CloudKit")
                Text("We also utilize CloudKit, a cloud-based storage and synchronization service...")
                
                Spacer()
                
                Text("2. Use of Data")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("2.1 We may use the data collected through Core Data and CloudKit...")
                
                Text("2.2 We do not use the data collected through Core Data and CloudKit for any other purposes...")
                
                Spacer()
                
                Text("3. Data Security")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("We implement reasonable security measures to protect the confidentiality and integrity...")
                
                Spacer()
                
                Text("4. Data Retention")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("We retain the data collected through Core Data and CloudKit for as long as necessary...")
                
                Spacer()
                
                Text("5. Data Sharing and Disclosure")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("5.1 We do not sell or disclose your data collected through Core Data and CloudKit...")
                
                Spacer()
                
                Text("6. Children's Privacy")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Our Service is not intended for children under the age of [13/16/18, depending on applicable law]...")
                
                Spacer()
                
                Text("7. Changes to this Policy")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("We may update this Policy from time to time...")
                
                Spacer()
                
                Text("8. Contact Us")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("If you have any questions or concerns about this Privacy Policy or our data practices...")
            }
            .padding()
        }
        .navigationBarTitle("Privacy Policy", displayMode: .inline)
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
*/
