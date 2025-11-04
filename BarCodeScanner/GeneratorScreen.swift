//
//  GeneratorScreen.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 04/11/2025.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
enum CodeType: String, CaseIterable {
    case qrcode =  "Qr code"
    case barcode = "Bar code"
}
struct GeneratorScreen: View {
    @State var textFieldText = ""
    @State var codeType: CodeType = .qrcode
    let qrCodeFilter = CIFilter.qrCodeGenerator()
    let barCodeFilter = CIFilter.code128BarcodeGenerator()
    let context = CIContext()
    var body: some View {
        VStack {
            TextField("enter your text to genrate code", text: $textFieldText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
           
            if textFieldText != "" {
                    Image(uiImage: generateBarcode(from: textFieldText))
                        .resizable()
                        .interpolation(.none)
                        .frame(width: 350, height: 350)
                        .aspectRatio(contentMode: .fill)
            }else{
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 350, height: 350)
                    .foregroundStyle(Color.gray.opacity(0.4))
            }
            Picker(codeType.rawValue,selection: $codeType) {
                ForEach(CodeType.allCases, id: \.self) { type in
                    Text("\(type.rawValue)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.vertical,10)
        }
        
    }
    
    
    func generateQrcode(from text: String) -> UIImage {
        let data = Data(text.utf8)
        qrCodeFilter.setValue(data,forKey: "inputMessage")
        guard let outputCIImage = qrCodeFilter.outputImage else{
            return UIImage(systemName: "xmark")!
        }
        let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent)!
        return UIImage(cgImage: cgImage)
//       switch(codeType) {
//           case .qrcode:
//           qrCodeFilter.setValue(data, forKey: "qrcodeMessage")
//           if let unwrappedCiImage = qrCodeFilter.outputImage{
//               ciImage = unwrappedCiImage
//           }
//           else {
//               return UIImage(systemName: "xmark")!
//           }
//           
//       case .barcode:
//           barCodeFilter.message = data
//           if let unwrappedCiImage = qrCodeFilter.outputImage{
//               ciImage = unwrappedCiImage
//           }
//           else {
//               return UIImage(systemName: "xmark")!
//           }
//        }
    }
    
    func generateBarcode(from text: String) -> UIImage {
        let data = Data(text.utf8)
        barCodeFilter.message = data
        guard let outputCIImage = barCodeFilter.outputImage else{
            return UIImage(systemName: "xmark")!
        }
        let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent)!
        return UIImage(cgImage: cgImage)
    }
}
#Preview {
    GeneratorScreen()
}
