//
//  LinkComposerActionsView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/30/21.
//

import SwiftUI

struct LinkComposerActionsView: View {
    var appName: String
    var actions: [Action]
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        List {
            Section {
                ForEach(actions, id: \.name) { action in
                    if action.options == nil {
                        Text(action.name)
                    } else if let options = action.options {
                        NavigationLink(
                            destination: LinkComposerActionOptionsView(options: options, action: action),
                            label: {
                                Text(action.name)
                            })
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(appName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            // Save
            
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
        })
    }
}

struct LinkComposerOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LinkComposerActionsView(appName: "Lookup", actions: apps[1].actions!)
        }
    }
}
