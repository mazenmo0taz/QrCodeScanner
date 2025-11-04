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
            ScannerScreen()
            .navigationTitle("Barcode Scanner")
        }
    }
       
}

#Preview {
    ContentView()
}


