//
//  LinkComposerActionsView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/30/21.
//

import SwiftUI

struct LinkComposerActionsView: View {
    @State var appName: String
    @State var actions: [Action]
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        List {
            Section {
                ForEach(actions, id: \.name) { action in
                    if action.options == nil {
                        Text(action.name)
                    } else if action.options != nil {
//                        NavigationLink(
//                            destination: LinkComposerActionOptionsView(options: action.options),
//                            label: {
//                                Text(action.name)
//                            })
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
            let actions = [
                Action(name: "Launch Lookup",
                       url: "lookupapp://",
                       description: nil,
                       options: nil
                ),
                Action(name: "Open Collection",
                       url: "lookupapp://?collection='{{$0}}'",
                       description: nil,
                       options: [
                        Option(name: "Name",
                               placeholder: "Action Name",
                               defaultText: "Open Collection",
                               helpText: nil
                        )]
                )]
            
            LinkComposerActionsView(appName: "Lookup", actions: actions)
        }
    }
}
