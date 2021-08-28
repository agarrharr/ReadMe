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
    @State var tabSelection = 1
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    
    let rows: [GridItem] =
            Array(repeating: .init(.fixed(40)), count: 3)
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: systemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(.systemGreen))
                    .cornerRadius(16)
                List {
                    Section(header: Text("Name")) {
                        TextField("Enter the name", text: $name)
                    }
                    Section(header: Text("URL")) {
                        TextField("Enter the URL", text: $url)
                    }
                    Section(header: Text("Image")) {
                        Picker("", selection: $tabSelection) {
                            Text("Color").tag(1)
                            Text("Glyph").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        if (tabSelection == 1) {
                            Text("Colors")
                        } else {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: rows, spacing: 0) {
                                    ForEach(systemNames, id: \.self) { systemName in
                                        Image(systemName: systemName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.gray)
                                            .padding(8)
                                            .background(
                                                systemName == self.systemName
                                                ? Color(.lightGray)
                                                    : Color(.clear)
                                            )
                                            .cornerRadius(8.0)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                self.systemName = systemName
                                            }
                                    }
                                }
                            }
                        }
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
                    link = Link.createWith(url: url, name: name, systemName: systemName, in: viewContext)
                    
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
