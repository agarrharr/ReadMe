//
//  BooksView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/27/21.
//

import SwiftUI

struct BooksView: View {
    @State var isPresentingAddBookSheet = false
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    var body: some View {
        List {
            ForEach(books, id: \.self) { book in
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
        .navigationBarTitle("Books")
        .navigationBarItems(
            trailing: Button(action: { isPresentingAddBookSheet = true}) {
                Text("Add Book")
            }
        )
        .sheet(isPresented: $isPresentingAddBookSheet, content: {
            NavigationView {
                CreateBookView()
            }
        })
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let book = Book(context: context)
        book.title = "Hello"
        
        return NavigationView {
            BooksView()
                .environment(\.managedObjectContext, context)
        }
    }
}
