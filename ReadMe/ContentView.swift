//
//  ContentView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 4/19/21.
//

import SwiftUI

struct ContentView: View {
    @State var selectedIndex: Int = -1
    @State var isPresentingAddBookSheet = false
    @State var isPresentingScanner = false
    @State var barcode = ""
    
    var body: some View {
        NavigationView {
            VStack {
            Text(barcode)
            BooksView()
                .navigationBarTitle("Read Me")
                .navigationBarItems(
                    leading:
                        Button(action: { isPresentingScanner = true}) {
                            Text("Scan barcode")
                        },
                    trailing:
                        HStack {
                            Button(action: { isPresentingAddBookSheet = true}) {
                                Text("Add book")
                            }
                        }
                )
                .sheet(isPresented: $isPresentingAddBookSheet, content: {
                    CreateBookView()
                })
                .sheet(isPresented: $isPresentingScanner, content: {
                    ScannerView(barcode: $barcode)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
