//
//  BooksView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/27/21.
//

import SwiftUI

struct BooksView: View {
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    var body: some View {
        List {
            ForEach(books, id: \.self) { book in
                ForEach(book.linkArray, id: \.self) { link in
                    NavigationLink(
                        destination: BookView(book: book),
                        label: {
                            HStack {
                                // TODO: Add book image?
                                // Image(systemName: link.symbolName ?? "link")
                                Text(book.title)
                            }
                        })
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
