//
//  ScannerViewModel.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 02/11/2025.
//

import SwiftUI

@Observable
class ScannerScreenViewModel{
    var scannedCode = ""
    var alertItem:AlertItem?
    var textColor : Color{
        scannedCode.isEmpty ? Color.secondary : Color.green
    }
    var ScannedCodeText : String{
        scannedCode.isEmpty ? "No Code Found": scannedCode
    }
    
}
