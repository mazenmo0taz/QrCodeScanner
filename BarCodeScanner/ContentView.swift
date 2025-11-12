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
                   
                GeneratorScreen()
                    .tabItem {
                        Label("Generate",systemImage: "qrcode")
                    }
            }
    }
}

#Preview {
    ContentView()
}


