//
//  BooksView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/27/21.
//

import CoreData
import SwiftUI

struct BooksView: View {
    @State private var isPresentingAddBookSheet = false
    
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    var body: some View {
        List {
            ForEach(books, id: \.self) { book in
                NavigationLink(
                    destination: LinksView(book: book),
                    label: {
                        HStack {
                            // TODO: Add book image?
                            // Image(systemName: link.symbolName ?? "link")
                            Text(book.title)
                        }
                    })
            }
            .onDelete(perform: removeBooks)
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
    
    func removeBooks(at offsets: IndexSet) {
        for index in offsets {
            let book = books[index]
            viewContext.delete(book)
        }
        do {
            try viewContext.save()
        } catch {
            print("Failed to delete books: \(error)")
        }
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
