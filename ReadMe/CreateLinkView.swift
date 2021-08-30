//
//  CreateLinkView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/27/21.
//

import CoreData
import SwiftUI

struct CreateLinkView: View {
    @State private var url: String = ""
    @State private var name: String = ""
    @State var systemName: String = "link"
    @Binding var link: Link?
    @State private var isPresentingIconSheet = false
    @StateObject private var linkComposer = LinkComposer()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    
    var body: some View {
        VStack {
            List {
                Section {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Link name", text: $name)
                    }
                    HStack {
                        Text("URL")
                        Spacer()
                        TextField("url://", text: $url)
                    }
                }
                
                Section {
                    HStack {
                        Text("Link Composer")
                        Spacer()
                    }
                    .onTapGesture {
                        linkComposer.isPresenting = true
                    }
                    .sheet(isPresented: $linkComposer.isPresenting) {
                        url = linkComposer.url
                    } content: {
                        NavigationView {
                            LinkComposerView(url: $url)
                        }
                        .environmentObject(linkComposer)
                    }
                }
                
                Section(header: Text("Options")) {
                    HStack {
                        Text("Icon")
                        Spacer()
                        Image(systemName: systemName)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isPresentingIconSheet = true
                    }
                    .sheet(isPresented: $isPresentingIconSheet, content: {
                        NavigationView {
                            IconEditView(systemName: $systemName)
                        }
                    })
                    
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Link")
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
                    link = Link(context: viewContext)
                    link!.url = url
                    link!.name = name
                    link!.symbolName = systemName
                    
                    self.presentationMode.wrappedValue
                        .dismiss()
                }) {
                    Text("Save")
                        .fontWeight(.bold)
                })
            Spacer()
        }
    }
}

struct CreateLinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateLinkView(link: .constant(Link()))
                .environmentObject(LinkComposer())
        }
    }
}
