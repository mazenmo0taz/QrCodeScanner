//
//  GeneratorScreenViewModel.swift
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

@Observable
class GeneratorScreenViewModel{
    var textFieldText = "" {
        didSet {
            generateCode()
        }
    }
    var codeType: CodeType = .qrcode{
        didSet {
            generateCode()
        }
    }
    let qrCodeFilter = CIFilter.qrCodeGenerator()
    let barCodeFilter = CIFilter.code128BarcodeGenerator()
    let context = CIContext()
    var generatedImage: UIImage = UIImage(systemName: "xmark")!
    var alertitem: AlertItem?
    var showAlert = false
    func generateCode(){
        let data = Data(textFieldText.utf8)
        let outputCIImage:CIImage?
       switch(codeType) {
           case .qrcode:
           qrCodeFilter.setValue(data,forKey: "inputMessage")
           outputCIImage = qrCodeFilter.outputImage

       case .barcode:
           barCodeFilter.message = data
           outputCIImage = barCodeFilter.outputImage
        }
        
        guard let outputCIImage = outputCIImage else{
            alertitem = GenratorScreenAlertContent.failedToGetOutputCIImageAlert
            showAlert = true
            return
        }
        let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent)!
        generatedImage = UIImage(cgImage: cgImage)
    }
}
