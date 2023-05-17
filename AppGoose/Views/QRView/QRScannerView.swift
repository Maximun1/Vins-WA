//
//  QRScannerView.swift
//  AppGoose
//
//  Created by Max Bezzabara on 5/10/23.
//

import SwiftUI
import ProgressHUD
import AVFoundation

struct QRScannerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingScanner = true
    @State private var scannedCodes: [String] = []
    
    @State private var textfld: String = ""
    @State private var errorAlert: Bool = false
    
    private let customColorScheme = ColorScheme(color1: Color.blue, color2: Color.yellow.opacity(0.8))
    
    @State private var presentSelectingCompaniesView: Bool = false
    @State var thisTx = thisTest()
    @State var switchBtn: Bool = false
    
    @EnvironmentObject var indexGr: IndexGrabber
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.yellow.opacity(0.8).ignoresSafeArea(.all)
                content
            }.navigationBarItems(
                leading:
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Home")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.red)
                            .cornerRadius(8)
                    })
        .navigationBarTitle("QR Scanner", displayMode: .inline)
        }.fullScreenCover(isPresented: $presentSelectingCompaniesView) {
            SelectingCompaniesView()
                .environmentObject(indexGr)
                .environmentObject(thisTx)
        }
    }
    
    @ViewBuilder
    var content: some View {
        VStack {
            textFieldView
                .padding(.horizontal)
            if isShowingScanner {
                scanner
                Spacer()
            } else {
                scanned
                    .alert("Error", isPresented: $errorAlert) {
                        Button("OK", role: .cancel) {
                            errorAlert = false
                        }
                    } message: {
                        Text("Invalid processed strings")
                    }
                Spacer()
            }
            actionButtons
        }
    }
    
    var textFieldView: some View {
        TextField("Enter VIN (If Camera Is Not Working)", text: $textfld)
            .foregroundColor(.black)
            .keyboardType(.asciiCapable)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .colorMultiply(.gray) // Apply grayscale effect
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .padding(.top)
    }
    
    @ViewBuilder
    var scanner: some View {
        ScannerView(scannedCodes: $scannedCodes)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    var scanned: some View {
        VStack {
            HStack {
                Text("Scanned Codes:")
                    .font(.title)
                    .padding()
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading) {
                    ForEach(processedStrings(), id: \.self) { code in
                        Text("\(code)")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                Spacer()
            }
            
            Spacer()
        }.frame(maxHeight: .infinity, alignment: .leading)
    }
    
    var actionButtons: some View {
        HStack {
            
            Spacer()
            
            if switchBtn {
                Button("Scan QR Codes") {
                    withAnimation {
                        switchBtn.toggle()
                        isShowingScanner = true
                    }
                }
                .buttonStyle(CustomButtonStyle(color: customColorScheme.color1))
            } else {
                Button("Stop Scanning") {
                    switchBtn.toggle()
                    processScannedCodes()
                }
                .buttonStyle(CustomButtonStyle(color: customColorScheme.color1))
            }
        }.padding()
    }
    // MARK: Processing Scanned Codes
    
    func processScannedCodes() {
        let stringsCount = processedStrings().count
        let isTextFieldEmpty = !textfld.isEmpty
        let isValidTextField = !checkTextField(textField: textfld) && textfld.count >= 6
        if isTextFieldEmpty && isValidTextField {
            errorAlert = false
            thisTx.vin = textfld
        } else {
            if stringsCount > 2 || stringsCount == 0 {
                errorAlert = true
            } else {
                errorAlert = false
                for i in 0..<processedStrings().count {
                    var test: [String] = processedStrings()
                    test[i] = test[i].replacingOccurrences(of: "MAILTO:", with: "")
                    test[i] = test[i].replacingOccurrences(of: "http://", with: "")
                    if containsOnlyStringsAndNumbers(test[i]) {
                        thisTx.vin = test[i]
                    } else {
                        thisTx.getCompanyName = test[i]
                    }
                }
            }
        }
        
        // MARK: TESTING WITHOUT QR MODE
        //thisTx.vin = "1234567890"
        //thisTx.getCompanyName = "Maxs"
        
        withAnimation {
            isShowingScanner = false
        }
        
        //thisTx.getEmail = "donparadox@gmail.com"
        
        if !errorAlert {
            presentSelectingCompaniesView.toggle()
        }
    }
    
    func containsOnlyStringsAndNumbers(_ input: String) -> Bool {
        let characterSet = CharacterSet.alphanumerics.inverted
        return input.rangeOfCharacter(from: characterSet) == nil
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func processedStrings() -> [String] {
        var uniqueStrings = Set<String>()
        
        uniqueStrings = Set(scannedCodes)
        
        return Array(uniqueStrings)
    }
    
    private func checkTextField(textField: String) -> Bool {
        let text = textField
        return text.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
}

struct CustomButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ColorScheme {
    let color1: Color
    let color2: Color
    
    var background: some View {
        LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}


struct ScannerView: UIViewRepresentable {
    @Binding var scannedCodes: [String]
    
    func makeUIView(context: Context) -> UIView {
        if AVCaptureDevice.default(for: .video) != nil {
            let scannerView = ScannerUIView.createAndSetup()
            scannerView?.delegate = context.coordinator
            return scannerView!
        } else {
            return makePlaceholderView()
        }
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannedCodes: $scannedCodes)
    }
    
    func makePlaceholderView() -> UIView {
        let label = UILabel()
        label.text = "Camera not available"
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }
    
    class Coordinator: NSObject, ScannerUIViewDelegate {
        @Binding var scannedCodes: [String]
        
        init(scannedCodes: Binding<[String]>) {
            _scannedCodes = scannedCodes
        }
        
        func didScanQRCodeWithResult(result: String) {
            scannedCodes.append(result)
        }
        
        func didScanMultipleQRCodesWithResults(results: [String]) {
            scannedCodes.append(contentsOf: results)
        }
    }
}


protocol ScannerUIViewDelegate: AnyObject {
    func didScanQRCodeWithResult(result: String)
    func didScanMultipleQRCodesWithResults(results: [String])
}

class ScannerUIView: UIView, AVCaptureMetadataOutputObjectsDelegate {
    weak var delegate: ScannerUIViewDelegate?
    private var scannedCodes: [String] = []
    private let captureSession: AVCaptureSession
    private let videoPreviewLayer: AVCaptureVideoPreviewLayer
    
    init(captureSession: AVCaptureSession) {
        self.captureSession = captureSession
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        super.init(frame: .zero)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(videoPreviewLayer)
        
        let metadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(metadataOutput)
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .code128]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoPreviewLayer.frame = bounds
    }
    
    static func createAndSetup() -> ScannerUIView? {
        guard let captureDevice = AVCaptureDevice.default(for: .video),
              let captureInput = try? AVCaptureDeviceInput(device: captureDevice) else {
            return nil
        }
        
        let captureSession = AVCaptureSession()
        captureSession.addInput(captureInput)
        
        let scannerView = ScannerUIView(captureSession: captureSession)
        
        DispatchQueue.global(qos: .background).async {
            captureSession.startRunning()
        }
        
        return scannerView
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        var scannedResults: [String] = []
        
        for metadataObject in metadataObjects {
            if let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
               let code = readableObject.stringValue {
                if !scannedCodes.contains(code) {
                    scannedResults.append(code)
                    scannedCodes.append(code)
                }
            }
        }
        
        if !scannedResults.isEmpty {
            if scannedResults.count == 1 {
                delegate?.didScanQRCodeWithResult(result: scannedResults[0])
            } else {
                delegate?.didScanMultipleQRCodesWithResults(results: scannedResults)
            }
        }
    }
}
