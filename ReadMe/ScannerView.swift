//
//  ScannerView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/28/21.
//

import AVFoundation
import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    let barcode: Binding<String?>
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        let scanner = ScannerViewController()
        scanner.delegate = context.coordinator
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: ScannerViewControllerDelegate {
        var parent: ScannerView
        
        init(_ parent: ScannerView) {
            self.parent = parent
        }
        
        func scanOccured(_ viewController: ScannerViewController, barcode: String) {
            parent.barcode.wrappedValue = barcode
        }
    }
}
