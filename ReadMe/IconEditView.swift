//
//  IconEditView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/28/21.
//

import SwiftUI

struct IconEditView: View {
    @State var tabSelection = 1
    @State var temporarySystemName: String? = nil
    @Binding var systemName: String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let rows: [GridItem] =
        Array(repeating: .init(.fixed(40)), count: 3)
    
    var body: some View {
        VStack {
            Image(systemName: temporarySystemName ?? systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
                .foregroundColor(.white)
                .background(Color(.systemGreen))
                .cornerRadius(16)
                .padding()
            
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
                                    temporarySystemName ?? self.systemName == systemName
                                        ? Color(.lightGray)
                                        : Color(.clear)
                                )
                                .cornerRadius(8.0)
                                .onTapGesture {
                                    temporarySystemName = systemName
                                }
                        }
                    }
                }
            }
            Spacer()
        }
        .navigationBarTitle("Icon")
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
                systemName = temporarySystemName ?? systemName
                
                self.presentationMode.wrappedValue
                    .dismiss()
            }) {
                Text("Save")
                    .fontWeight(.bold)
            })
    }
}

struct IconEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            IconEditView(systemName: .constant("link"))
        }
    }
}
