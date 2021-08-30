//
//  LinkComposerActionOptionsView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/30/21.
//

import SwiftUI

struct LinkComposerActionOptionsView: View {
    @State var options: [Option]
    @State var optionValues: [String] = []
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        List {
            Section {
                ForEach(options, id: \.name) { option in
                    HStack {
                        Text(option.name)
                        Spacer()
                        //TextField(option.placeholder, text: option.placeholder)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Options")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            // Save
            
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
        })
    }
}

struct LinkComposerActionOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        let options = [
            Option(name: "Name",
                   placeholder: "Action Name",
                   defaultText: "Open Collection",
                   helpText: nil
            ),
            Option(name: "Collection",
                   placeholder: "Collection Name",
                   defaultText: "Found while reading",
                   helpText: nil
            )
        ]
        
        NavigationView {
            LinkComposerActionOptionsView(options: options)
        }
    }
}
