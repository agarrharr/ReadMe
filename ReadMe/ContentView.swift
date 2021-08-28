//
//  ContentView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 4/19/21.
//

import SwiftUI

struct ContentView: View {
    @State var isPresentingAddBookSheet = false
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    var body: some View {
        NavigationView {
            BooksView()
                .navigationBarTitle("Read Me")
                .navigationBarItems(
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
