//
//  GeneratorScreenViewModel.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 04/11/2025.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import Photos
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
            return
        }
        let scalledImage = outputCIImage.transformed(by: CGAffineTransform(scaleX: codeType == .barcode ? 5 : 10, y: codeType == .barcode ? 5 : 10))
        let cgImage = context.createCGImage(scalledImage, from: scalledImage.extent)!
        generatedImage = UIImage(cgImage: cgImage)
    }
    
    func shareImage(){
        if generatedImage != nil{
            isSheetPresented = true
        } else {
            alertitem = GenratorScreenAlertContent.failedToShareImageAlert
        }
    }
    
    func checkPhotosLibraryAuthorizationStatusAndSave(){
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized, .limited:
                self.saveImage()
            case .denied, .restricted:
                if self.generatedImage == nil {
                    self.alertitem = GenratorScreenAlertContent.failedToShareImageAlert
                }else {
                    self.alertitem = GenratorScreenAlertContent.photoAccessDeniedAlert
                }
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
                    if status == .authorized || status == .limited {
                        self.saveImage()
                        self.alertitem = GenratorScreenAlertContent.imageSavedSuccessfullyAlert
                    } else {
                        self.alertitem = GenratorScreenAlertContent.photoAccessDeniedAlert
                    }
                }
            @unknown default:
                break
            }
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
        self.alertitem = GenratorScreenAlertContent.imageSavedSuccessfullyAlert
    }
}
