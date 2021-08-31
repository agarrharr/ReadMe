//
//  IconEditView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/28/21.
//

import SwiftUI

struct IconEditView: View {
    @Binding var systemName: String
    
    @State private var tabSelection = 1
    @State private var temporarySystemName: String? = nil
    @State private var color: Color = Color(.red)
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let columns: [GridItem] = Array(repeating: GridItem(), count: 5)
    
    var body: some View {
        VStack {
            Image(systemName: temporarySystemName ?? systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
                .foregroundColor(.white)
                .background(color)
                .cornerRadius(16)
                .padding()
            
            Picker("", selection: $tabSelection) {
                Text("Color").tag(1)
                Text("Glyph").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            if (tabSelection == 1) {
                ColorPicker("Color", selection: $color, supportsOpacity: false)
            } else {
                ScrollViewReader { proxy in
                            ScrollView(.vertical) {
                                LazyVGrid(columns: columns) {
                                    ForEach(SymbolsList, id: \.self) { symbol in
                                        Button {
                                            temporarySystemName = symbol
                                        } label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .foregroundColor(symbol == temporarySystemName ? .accentColor : Color(.secondarySystemGroupedBackground))
                                                    .aspectRatio(1, contentMode: .fill)
                                                Image(systemName: symbol)
                                                    .imageScale(.large)
                                                    .foregroundColor(.primary)
                                            }
                                        }
                                        .id(symbol)
                                    }
                                }
                                .padding()
                            }
                            .background(Color(.systemGroupedBackground)
                                            .edgesIgnoringSafeArea(.bottom))
                            .onAppear {
                                proxy.scrollTo(temporarySystemName, anchor: .center)
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
