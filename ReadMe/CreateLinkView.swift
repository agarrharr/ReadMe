//
//  CreateLinkView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/27/21.
//

import CoreData
import SwiftUI

//let symbolNames = []

struct CreateLinkView: View {
    @State var url: String = ""
    @State var systemName: String = ""
    @Binding var link: Link?
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: systemName)
                List {
                    Section(header: Text("URL")) {
                        TextField("Enter the URL", text: $url)
                    }
                    Section(header: Text("Image")) {
                        TextField("Enter the symbolName", text: $systemName)
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarItems(
                leading: Button(action: {
                    self.presentationMode.wrappedValue
                        .dismiss()
                }) {
                    Text("Cancel")
                        .fontWeight(.bold)
                },
                trailing: Button(action: {
                    link = Link.createWith(url: url, systemName: systemName, in: viewContext)
                    
                    self.presentationMode.wrappedValue
                        .dismiss()
                }) {
                    Text("Save")
                        .fontWeight(.bold)
                })
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
