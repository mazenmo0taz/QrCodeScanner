//
//  Alerts.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 02/11/2025.
//

import SwiftUI
struct AlertItem: Identifiable {
    var id = UUID()
    var title: String
    var message: String
    var dismissButton: Alert.Button
}

struct AlertContent{
    static let invalidCameraDeviceAlert = AlertItem(title: "camera not available", message: "faild to find available camera", dismissButton: .default(Text("OK")))
    static let failedToAddInputToSessionAlert = AlertItem(title: "failed to create device input", message: "Failed to add AVCaptureDeviceInput", dismissButton: .default(Text("OK")))
    static  let failedToAddOutputToSessionAlert =  AlertItem(title: "failed to add device output", message: "Failed to add output to the session", dismissButton: .default(Text("OK")))
    static let failedToReadCodeAlert = AlertItem(title:"Invalud code", message: "Invalud code, failed to read code please try again we only accept QR codes/barcodes in this app", dismissButton: .default(Text("OK")))
    static  let failedToSetupPreviewLayerAlert =  AlertItem(title:"Failed to set up preview", message: "Failed to set up preview layer", dismissButton: .default(Text("OK")))
}

struct GenratorScreenAlertContent{
    static let failedToGetOutputCIImageAlert = AlertItem(title: "failed to generate code", message: "failed To Get Output CIImage from input text please enter a valid text", dismissButton: .default(Text("OK")))
}
