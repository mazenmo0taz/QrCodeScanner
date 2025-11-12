//
//  ScannerScreen.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 04/11/2025.
//

import SwiftUI
struct ScannerScreen: View {
    @State var scannerViewModel = ScannerScreenViewModel()
    @Environment(\.openURL) var openURL
    var body: some View {
        NavigationStack{
            VStack{
                Text("place the bar code / QR code here")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                
                Text("Scanning will start automatically")
                    .font(.system(.headline,weight: .semibold))
                    .foregroundStyle(.secondary)
                
                CameraPreviewView(scannerViewModel: scannerViewModel)
                   
                
                Label("Scanned Code:",systemImage: "barcode.viewfinder")
                    .font(.system(.title,design: .rounded))
                    .bold()
                Text(scannerViewModel.ScannedCodeText)
                    .font(.system(.largeTitle,design: .rounded,weight: .semibold))
                    .foregroundStyle(scannerViewModel.textColor)
                    .lineLimit(3)
                    .padding(8)
            }
            .navigationTitle("Barcode Scanner")
            .confirmationDialog("Open this link?", isPresented: $scannerViewModel.isShowingConfirmationDialog, titleVisibility: .visible){
                    Button("Open") {
                        openURL(URL(string:scannerViewModel.ScannedCodeText)!)
                    }
                
                Button("Cancel", role: .cancel) { }
            } message: {
                Text(scannerViewModel.scannedCode)
            }
            
            .alert(item: $scannerViewModel.alertItem) { item in
                    Alert(title: Text(item.title), message: Text(item.message), dismissButton: item.dismissButton)
            }
        }
    }
}

#Preview {
    ScannerScreen()
}
