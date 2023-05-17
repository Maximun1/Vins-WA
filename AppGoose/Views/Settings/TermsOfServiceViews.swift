//
//  TermsOfServiceViews.swift
//  AppGoose
//
//  Created by Max Bezzabara on 5/11/23.
//

import SwiftUI

struct TermsOfServiceView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var chapterTitles: [String] = ["1. Introduction", "2. Your Account", "3. Data Storage and Security", "4. Intellectual Property", "5. Usage Restrictions", "6. Disclaimer of Warranties", "7. Limitation of Liability", "8. Indemnification", "9. Modification of Terms", "10. Governing Law and Jurisdiction", "11. Contact Information", "12. Termination", "13. Severability", "14. Waiver", "15. Entire Agreement"]
    @State var chapterDescriptions: [String] = ["Welcome to our app. By using our app, you agree to these terms of service. Please read them carefully.", "To access certain features of the app, you must create an account. You are responsible for safeguarding your account credentials and for any activities or actions under your account. We reserve the right to suspend or terminate your account if you violate these terms.", "We use CoreData and CloudKit to store your data. All data used by the app is stored locally on your device using CoreData and synced with your iCloud account using CloudKit. No information is shared with third parties or stored on external servers. Apple manages your data in iCloud, and their privacy policy applies to the data stored in CloudKit.", "All content, features, and functionality within the app, including but not limited to, text, graphics, logos, icons, images, audio clips, and software, are the exclusive property of the app developer and protected by international copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.", "You agree not to use the app in any way that:\nViolates any applicable law or regulation.\nInfringes upon the rights of any third party, including but not limited to, intellectual property rights, privacy, or publicity rights.\nEngages in any harassing, threatening, intimidating, or discriminatory behavior.", "The app is provided on an \"as is\" basis. We make no representations or warranties of any kind, express or implied, as to the operation of the app or the information, content, materials, or products included in the app. To the full extent permissible by applicable law, we disclaim all warranties, express or implied, including but not limited to, implied warranties of merchantability and fitness for a particular purpose.", "In no event shall we be liable for any direct, indirect, incidental, special, consequential, or punitive damages, including but not limited to, lost profits, lost data, or business interruption, arising out of or in connection with your use, or inability to use, the app.", "You agree to indemnify, defend, and hold harmless the app developer and its affiliates, officers, directors, employees, agents, licensors, and suppliers from and against all losses, expenses, damages, and costs, including reasonable attorneys' fees, resulting from any violation of these terms or any activity related to your account (including negligent or wrongful conduct) by you or any other person accessing the app using your account.", "We reserve the right to modify these terms at any time. Your continued use of the app following any changes to the terms constitutes your acceptance of such changes.", "These terms and any dispute arising out of or related to them shall be governed by and construed in accordance with the laws of [Your Country or State], without regard to its conflict of law provisions. You agree to submit to the exclusive jurisdiction of the courts located in [Your Country or State] for the resolution of any disputes arising out of or relating to these terms.", "If you have any questions or concerns about these terms, please contact us at max.bezzabara@gmail.com.", "We reserve the right, in our sole discretion, to terminate your access to the app and the related services or any portion thereof at any time, without notice. If you breach any of the terms, your right to use the app will immediately cease.", "If any provision of these terms is found to be unenforceable or invalid, that provision shall be limited or eliminated to the minimum extent necessary so that the remaining terms shall otherwise remain in full force and effect.", "Our failure to exercise or enforce any right or provision of these terms shall not constitute a waiver of such right or provision.", "These terms, together with any other legal notices and agreements published by us within the app, shall constitute the entire agreement between you and us concerning the app. In the event of any conflict between these terms and any other legal notice or agreement, these terms shall control."]
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Terms of Service")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        
                        ForEach(0..<chapterTitles.count, id: \.self) { i in
                            Text(chapterTitles[i])
                                .font(.headline)
                                .padding(.top, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(chapterDescriptions[i])
                                .padding(.top, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }.background(Colors(colors: .yellow.opacity(0.8)).ignoresSafeArea())
                .navigationBarTitle("Terms of Service", displayMode: .inline)
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

struct TermsOfServiceView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceView()
    }
}
