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
    @State var isPresentingAddLinkSheet = false
    @State var links: [Link] = []
    @State var newLink: Link?
    @State var barcode: String? = nil
    @State var isPresentingScanner = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    
    var body: some View {
        VStack {
            Text(barcode ?? "")
            
            if barcode != nil {
                Image(systemName: "placeholder image")
                    .data(url: URL(string: "https://covers.openlibrary.org/b/isbn/\(barcode!)-L.jpg")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
            }
            
            Button(action: { isPresentingScanner = true}) {
                Text("Scan barcode")
            }
            List {
                Section(header: Text("Title")) {
                    TextField("Enter a title", text: $title)
                    
                }
                Section(header: Text("Links")) {
                    ForEach(links, id: \.self) { link in
                        HStack {
                            Image(systemName: link.symbolName!)
                            Text(link.url!)
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
                ScannerView(barcode: $barcode)
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
