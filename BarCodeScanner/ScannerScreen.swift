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
    @State private var animateLine = false
    var body: some View {
         ZStack {
             
                ScannerView(scannedCode: $scannerViewModel.scannedCode, alertItem: $scannerViewModel.alertItem)
                    .padding(5)
             
                ForEach(0...1, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 5)
                        .trim(from:0.85,to:0.9)
                        .stroke(Color.green,style: StrokeStyle(lineWidth: 4))
                        .rotationEffect(Angle(degrees: Double(index*180)))
                        RoundedRectangle(cornerRadius: 5)
                            .trim(from:0.1,to:0.15)
                            .stroke(Color.blue,style: StrokeStyle(lineWidth: 4))
                            .rotationEffect(Angle(degrees: Double(index) * 180 ))
                }
             Rectangle()
                 .fill(.blue.gradient)
                 .frame(height: 2)
                 .offset(y: animateLine ? 170 : -170)
                 .shadow(radius: 3, x: 0, y: 10)
                 .animation(
                    Animation.linear(duration: 1)
                         .repeatForever(autoreverses: true),
                    value: animateLine
                 )
                 .onAppear {
                     animateLine = true
                 }
                 .padding(5)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 400)
            .clipped()
    }
    
}

#Preview {
    ScannerScreen()
}
