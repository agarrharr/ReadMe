//
//  CreateBookView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/27/21.
//

import CoreData
import SwiftUI

struct CreateBookView: View {
    @State var title: String = ""
    @State var isbn: String = ""
    @State var isPresentingAddLinkSheet = false
    @State var links: [Link] = []
    @State var newLink: Link?
    @State var isPresentingScanner = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    
    var body: some View {
        VStack {
            if isbn != "" {
                Image(systemName: "placeholder image")
                    .data(url: URL(string: "https://covers.openlibrary.org/b/isbn/\(isbn)-L.jpg")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
            }
            
            List {
                Section {
                    HStack {
                        Text("Title")
                        Spacer()
                        TextField("Enter the title", text: $title)
                    }
                    HStack {
                        Text("ISBN")
                        Spacer()
                        TextField("Enter the ISBN", text: $isbn)
                    }
                }
                
                Section {
                    Button(action: { isPresentingScanner = true }) {
                        HStack {
                            Image(systemName: "barcode")
                            Text("Scan barcode")
                            Spacer()
                        }
                    }
                }
                
                Section(header: Text("Links"), footer: Text("Links are an easy way to get to things related to this book. Don't worry, you can always add links later.")) {
                    ForEach(links, id: \.self) { link in
                        HStack {
                            Image(systemName: link.symbolName ?? "link")
                            Text(link.name ?? "")
                        }
                    }
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                        Text("Add link")
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isPresentingAddLinkSheet = true
                    }
                    
                }
            }
            .listStyle(GroupedListStyle())
            .sheet(isPresented: $isPresentingAddLinkSheet, onDismiss: {
                if newLink != nil {
                    links.append(newLink!)
                    newLink = nil
                }
                isPresentingAddLinkSheet = false
            }, content: {
                NavigationView {
                    CreateLinkView(link: $newLink)
                }
            })
            .sheet(isPresented: $isPresentingScanner, content: {
                ScannerView(barcode: $isbn)
            })
            Spacer()
        }
        .navigationBarTitle("Book")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: {
                self.presentationMode.wrappedValue
                    .dismiss()
            }) {
                Text("Cancel")
                    .fontWeight(.bold)
            },
            trailing: Button(action: {
                Book.createWith(title: title, links: links, in: viewContext)
                
                self.presentationMode.wrappedValue
                    .dismiss()
            }) {
                Text("Save")
                    .fontWeight(.bold)
            })
    }
}

struct CreateBook_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateBookView()
        }
    }
}
