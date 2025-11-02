//
//  ScannerViewModel.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 02/11/2025.
//

import SwiftUI
class ScannerViewModel: ObservableObject {
    @Published var isScanning: Bool = false
    @Published var scannedCode: String?
    @Published var alertItem: AlertItem
}
