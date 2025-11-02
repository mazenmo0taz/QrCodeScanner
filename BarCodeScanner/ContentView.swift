//
//  ContentView.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 16/10/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack{
                
                Text("place the bar code here")
                    .font(.system(.title, design: .rounded, weight: .bold))
                
                Text("Scanning will start automatically")
                    .font(.system(.headline,weight: .semibold))
                    .foregroundStyle(.secondary)
                
                ScanningView()
                    .padding()
                
                Label("Scanned Bar Code:",systemImage: "barcode.viewfinder")
                    .font(.system(.title,design: .rounded))
                    .bold()
                Text("No Bar Code Found")
                    .font(.system(.largeTitle,design: .rounded,weight: .semibold))
                    .foregroundStyle(.secondary)
                    .padding(10)
            }.navigationTitle("Barcode Scanner")
        }
    }
       
}

#Preview {
    ContentView()
}

struct ScanningView: View {
    @State var isScannning = false
    var body: some View {
        ZStack{
            ScannerView()
                .padding(2)
                .overlay(alignment:.top ,content: {
                    Rectangle()
                        .frame(height: 3)
                        .foregroundStyle(Color.blue)
                        .shadow(color: Color.black.opacity(0.8), radius: 8, y:8)
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true),value: isScannning)
                        .offset(y: isScannning ? 360 : 0)
                })
            
            
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
