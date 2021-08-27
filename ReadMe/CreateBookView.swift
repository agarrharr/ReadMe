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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Title", text: $title)
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Add Book")
            .navigationBarItems(trailing: Button(action: {
                Book.createWith(title: title, using: viewContext)
                
                self.presentationMode.wrappedValue
                    .dismiss()
            }) {
                Text("Save")
                    .fontWeight(.bold)
            })
        }
    }
}

struct CreateBook_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateBookView()
        }
    }
}
