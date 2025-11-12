//
//  ShareSheet.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 09/11/2025.
//
import SwiftUI
import UIKit
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { }
}
