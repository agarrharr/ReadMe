//
//  ContentView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 4/19/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            BooksView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
