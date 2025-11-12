//
//  ScannerView.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 16/10/2025.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    @Binding var alertItem:AlertItem?
    @Binding var isShowingConfirmationDialog: Bool
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    final class Coordinator: NSObject, ScannerVCDelegate {
        var scannerView: ScannerView
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didScan(code: String) {
            scannerView.scannedCode = code
            if code.hasPrefix("http") {
                scannerView.isShowingConfirmationDialog = true
            }
        }
        
        func didFindError(error: CameraError) {
            switch error {
            case .invalidCameraDevice:
                scannerView.alertItem = AlertContent.invalidCameraDeviceAlert
            case .failedToAddInputToSession:
                scannerView.alertItem = AlertContent.failedToAddInputToSessionAlert
            case .failedToAddOutputToSession:
                scannerView.alertItem = AlertContent.failedToAddOutputToSessionAlert
            case .failedToCreateDeviceInput:
                scannerView.alertItem = AlertContent.failedToAddInputToSessionAlert
            case .failedToReadCode:
                scannerView.alertItem = AlertContent.failedToReadCodeAlert
            case .failedToSetupPreviewLayer:
                scannerView.alertItem = AlertContent.failedToSetupPreviewLayerAlert
            }
        }
        
        
    }
    
}

