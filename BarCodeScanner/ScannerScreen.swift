//
//  ScannerScreen.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 04/11/2025.
//

import SwiftUI
struct ScannerScreen: View {
    @State var scannerViewModel = ScannerScreenViewModel()
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
                    .padding(8)
            }
            .navigationTitle("Barcode Scanner")
            .alert(item: $scannerViewModel.alertItem) { item in
                    Alert(title: Text(item.title), message: Text(item.message), dismissButton: item.dismissButton)
                }
        }
    }
}

struct CameraPreviewView: View {
    @State var scannerViewModel:ScannerScreenViewModel
    var body: some View {
        ZStack {
            ScannerView(scannedCode: $scannerViewModel.scannedCode, alertItem: $scannerViewModel.alertItem, isScanning: $scannerViewModel.isScannning)
                .padding(2)
                .overlay(alignment:.top ,content: {
                    Rectangle()
                        .frame(height: 3)
                        .foregroundStyle(Color.blue)
                        .shadow(color: Color.black.opacity(0.8), radius: 8, y:8)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true),value: scannerViewModel.isScannning)
                        .offset(y: scannerViewModel.isScannning ? 345 : 0)
                })
                .padding()
            ForEach(0...1, id: \.self) { index in
                RoundedRectangle(cornerRadius: 5,style: .circular)
                    .trim(from:0.6,to:0.64)
                    .stroke(Color.blue,style: StrokeStyle(lineWidth: 7))
                    .rotationEffect(Angle(degrees: Double(index*180)))
                RoundedRectangle(cornerRadius: 5,style: .circular)
                    .trim(from:0.86,to:0.9)
                    .stroke(Color.blue,style: StrokeStyle(lineWidth: 7))
                    .rotationEffect(Angle(degrees: Double(index*180)))
            }
        }
        .padding(3)
        .frame(maxWidth: .infinity, maxHeight: 370)
    }
}
