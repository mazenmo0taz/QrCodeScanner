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
            if textFieldText.isEmpty {
                return
            }else {
                generateCode()
            }
        }
    }
    var codeType: CodeType = .qrcode{
        didSet {
            if textFieldText.isEmpty {
                return
            }else {
                generateCode()
            }
           
        }
    }
    let qrCodeFilter = CIFilter.qrCodeGenerator()
    let barCodeFilter = CIFilter.code128BarcodeGenerator()
    let context = CIContext()
    var generatedImage: UIImage?
    var alertitem: AlertItem?
    var isAlertPresented = false
    var isSheetPresented = false
    
    
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
            isAlertPresented = true
            return
        }
        let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent)!
        generatedImage = UIImage(cgImage: cgImage)
    }
    
    func shareImage(){
        if generatedImage != nil{
            isSheetPresented = true
        } else {
            alertitem = GenratorScreenAlertContent.failedToShareImageAlert
        }
    }
    
    func saveImage(){
        guard let image = generatedImage else{
            alertitem = GenratorScreenAlertContent.failedToShareImageAlert
            return
        }
        DispatchQueue.main.async {
            UIImageWriteToSavedPhotosAlbum(image,nil,nil,nil)
        }
        alertitem = GenratorScreenAlertContent.imageSavedSuccessfullyAlert
    }
}
