//
//  BooksView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/27/21.
//

import SwiftUI

struct BooksView: View {
    @State var selectedBook = -1
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    var body: some View {
        List {
            ForEach(books, id: \.self) { book in
                Section(header: Text(book.title)) {
                    ForEach(book.linkArray, id: \.self) { link in
                        HStack {
                            Image(systemName: link.symbolName ?? "link")
                            Text(link.name ?? "")
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: link.url!)!)
                        }
                    }
                }
            }
            
            
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
