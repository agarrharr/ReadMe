//
//  LinkComposerActionOptionsView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/30/21.
//

import SwiftUI

struct LinkComposerActionOptionsView: View {
    var options: [Option]
    var action: Action
    
    @EnvironmentObject private var linkComposer: LinkComposer
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Name")
                    Spacer(minLength: 14.0)
                    TextField(action.actionName, text: $linkComposer.actionName)
                }
                ForEach(options.indices) { i in
                    HStack {
                        Text(options[i].name)
                        Spacer(minLength: 14.0)
                        TextField(options[i].placeholder, text: $linkComposer.optionValues[i])
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Options")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            linkComposer.updateURL()
        }) {
            Text("Done")
        })
        .onAppear {
            linkComposer.setAction(action: action)
        }
    }
}

struct LinkComposerActionOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        let options = [
            Option(name: "Collection",
                   placeholder: "Collection Name",
                   defaultText: "Found while reading",
                   helpText: nil
            )
        ]
        
        NavigationView {
            LinkComposerActionOptionsView(options: options, action: apps[1].actions[1])
                .environmentObject(LinkComposer())
        }
    }
}
