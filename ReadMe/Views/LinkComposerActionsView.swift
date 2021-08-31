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
    
    @EnvironmentObject private var linkComposer: LinkComposer
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        List {
            Section {
                ForEach(actions, id: \.labelName) { action in
                    if action.options == nil {
                        HStack {
                            Text(action.labelName)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            linkComposer.set(url: action.url, actionName: action.actionName)
                        }
                    } else if let options = action.options {
                        NavigationLink(
                            destination: LinkComposerActionOptionsView(options: options, action: action),
                            label: {
                                Text(action.labelName)
                            })
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(appName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
        })
    }
}

struct LinkComposerOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LinkComposerActionsView(appName: "Lookup", actions: apps[1].actions)
        }
    }
}
