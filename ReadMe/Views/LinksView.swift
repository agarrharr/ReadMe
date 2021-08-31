//
//  LinksView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/28/21.
//

import CoreData
import SwiftUI

struct LinksView: View {
    var book: Book
    
    @State private var newLink: Link?
    @State private var isPresentingAddLinkSheet = false
    @State private var isDeletingLink: Link?

    
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    
    let layout = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: layout, spacing: 12) {
                ForEach(book.linkArray, id: \.id) { link in
                    LinkView(link: link)
                        .contextMenu {
                            // Button(role: .destructive) { // TODO: add for iOS 15
                            Button {
                                isDeletingLink = link
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .padding(.horizontal)
            .animation(.default, value: book.linkArray)
        }
        .padding()
        .sheet(isPresented: $isPresentingAddLinkSheet, onDismiss: {
            if newLink != nil {
                book.add(link: newLink!, in: viewContext)
                newLink = nil
            }
            isPresentingAddLinkSheet = false
        }, content: {
            NavigationView {
                CreateLinkView(link: $newLink)
            }
        })
        .actionSheet(isPresented: Binding<Bool>(get: { isDeletingLink != nil }, set: { _ in })) {
            ActionSheet(title: Text("This action will be deleted"), buttons: [
                .default(Text("Delete Action").foregroundColor(.red)) {
                                deleteLink(link: isDeletingLink!)
                    isDeletingLink = nil
                            }
            ])
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: { isPresentingAddLinkSheet = true }, label: {
            Text("Add Action")
        }))
    }
    
    func deleteLink(link: Link) {
        viewContext.delete(link)
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to delete link: \(error)")
        }
    }
    
    func deleteLinks(at offsets: IndexSet) {
        for index in offsets {
            let link = book.linkArray[index]
            viewContext.delete(link)
        }
        do {
            try viewContext.save()
        } catch {
            print("Failed to delete links: \(error)")
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let link1 = Link(context: context)
        link1.url = "http://google.com"
        link1.name = "Google"
        link1.symbolName = "link"
        let link2 = Link(context: context)
        link2.url = "http://google.com"
        link2.name = "Goodreads"
        link2.symbolName = "g.square.fill"
        let link3 = Link(context: context)
        link3.url = "http://google.com"
        link3.name = "Start Timer"
        link3.symbolName = "timer"
        let link4 = Link(context: context)
        link4.url = "http://google.com"
        link4.name = "Notes"
        link4.symbolName = "note.text"
        
        let book = Book(context: context)
        book.title = "Watership Down"
        book.links = NSSet(array: [link1, link2, link3, link4])
        
        return NavigationView {
            LinksView(book: book)
                .environment(\.managedObjectContext, context)
        }
    }
}
