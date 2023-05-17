//
//  EmailingPhotosView.swift
//  AppGoose
//
//  Created by Max on 5/12/23.
//

import SwiftUI
import PhotosUI
import MessageUI

struct EmailingPhotosView: View {
    @Binding var isShowingEmailingPhotosView: Bool
    let selectedImages: [UIImage]
    @State var isShowingMailView = false
    @State var email: String
    @State var vin: String
    @State var companyType: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Emailing Photos")
                    .font(.title)
                    .padding()
                
                List(selectedImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                }
                
                Button(action: {
                    isShowingMailView = true
                }) {
                    Text("Send Email")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }.padding()
                .sheet(isPresented: $isShowingMailView) {
                    MailView(isShowing: $isShowingMailView, selectedImages: selectedImages, email: email, vin: vin, companyType: companyType)
                }
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                isShowingEmailingPhotosView = false
            }) {
                Text("Cancel")
            }
            )
        }
    }
}

struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let selectedImages: [UIImage]
    let email: String
    let vin: String
    let companyType: String
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        
        init(isShowing: Binding<Bool>) {
            _isShowing = isShowing
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            isShowing = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
        mail.setSubject("\(companyType), Vin: \(vin)")
        mail.setToRecipients(["\(email)"])
        
        // Attach the images to the email
        for (index, image) in selectedImages.enumerated() {
            // Convert the image to JPEG data with a lower compression quality
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                // Use "image/raw" as the mimeType instead of "image/jpeg"
                mail.addAttachmentData(imageData, mimeType: "image/raw", fileName: "image\(index + 1).raw")
            }
        }
        
        return mail
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {}
}
