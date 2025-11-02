//
//  ScannerView.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 16/10/2025.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator: NSObject, ScannerVCDelegate {
        func didScan(barcode: String) {
            print(barcode)
        }
        
        func didFindError(error: CameraError) {
            print(error.rawValue)
        }
        
        
    }
    
}

#Preview {
    ScannerView()
}
