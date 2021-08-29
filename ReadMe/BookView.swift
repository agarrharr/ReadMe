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
            CreateLinkView(link: $newLink)
        })
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: { isPresentingAddLinkSheet = true }, label: {
            Text("Add link")
        }))
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let book = Book.createWith(
            title: "Watership Down",
            links: [
                Link.createWith(url: "http://google.com", name: "Google", systemName: "link", in: viewContext),
                Link.createWith(url: "http://google.com", name: "Goodreads", systemName: "g.square.fill", in: viewContext),
                Link.createWith(url: "http://google.com", name: "Start Timer", systemName: "timer", in: viewContext),
                Link.createWith(url: "http://google.com", name: "Notes", systemName: "note.text", in: viewContext)
            ],
            in: viewContext)
        
        NavigationView {
            BookView(book: book)
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
