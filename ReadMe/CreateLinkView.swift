//
//  CreateLinkView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/27/21.
//

import CoreData
import SwiftUI

let systemNames = ["link", "link.circle.fill", "link.icloud.fill", "car.fill", "car.2.fill", "bolt.car.fill", "bus.fill", "bus.doubledecker.fill", "tram.fill", "tram.tunnel.fill", "bicycle"]

struct CreateLinkView: View {
    @State var url: String = ""
    @State var name: String = ""
    @State var systemName: String = systemNames[0]
    @Binding var link: Link?
    @State var isPresentingIconSheet = false
    
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
                    link = Link.createWith(url: url, name: name, systemName: systemName, in: viewContext)
                    
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
        }
    }
}
