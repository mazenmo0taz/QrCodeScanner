//
//  ContentView.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 16/10/2025.
//

import SwiftUI
struct ContentView: View {
    var body: some View {
            TabView{
                ScannerScreen()
                    .tabItem {
                        Label("Scan",systemImage: "qrcode.viewfinder")
                    }
                    .navigationTitle("Barcode Scanner")
                
                GeneratorScreen()
                    .tabItem {
                        Label("Generate",systemImage: "qrcode")
                    }
                    .navigationTitle("Barcode generator")
            }
            
      
        
        
    }
       
}

#Preview {
    ContentView()
}


