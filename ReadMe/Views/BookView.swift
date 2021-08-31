//
//  BookView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/28/21.
//

import CoreData
import SwiftUI

struct BookView: View {
    @State var book: Book
    @State var newLink: Link?
    @State var isPresentingAddLinkSheet = false
    
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    
    let layout = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: layout, spacing: 12) {
                ForEach(book.linkArray, id: \.self) { link in
                    VStack {
                        HStack {
                            Image(systemName: link.symbolName ?? "link")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "ellipsis.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                                .foregroundColor(.white)
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 1)
                        Text(link.name ?? "")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                    .frame(height: 90)
                    .padding(12)
                    .background(Color(.systemPurple))
                    .cornerRadius(20)
                    .onTapGesture {
                        if let url = URL(string: link.url ?? "") {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            }
            .padding(.horizontal)
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
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: { isPresentingAddLinkSheet = true }, label: {
            Text("Add Action")
        }))
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
            BookView(book: book)
                .environment(\.managedObjectContext, context)
        }
    }
}
