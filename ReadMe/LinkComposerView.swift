//
//  LinkComposerView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/29/21.
//

import SwiftUI

struct App {
    var appName: String
    var actions: [Action]
}

struct Action {
    var labelName: String
    var actionName: String
    var url: String
    var description: String?
    var options: [Option]?
}

struct Option {
    var name: String
    var placeholder: String
    var defaultText: String
    var helpText: String?
}

let apps: [App] = [
    App(appName: "Readwise", actions: [Action(labelName: "Launch Readwise", actionName: "Readwise", url: "readwise://", description: nil, options: nil)]),
    //"Scan Thing",
    //"Files",
    App(appName: "Lookup",
     actions: [
        Action(labelName: "Launch Lookup",
               actionName: "Lookup",
               url: "lookupapp://",
               description: nil,
               options: nil
        ),
        Action(labelName: "Open Collection",
               actionName: "OpenCollection",
               url: "lookupapp://?collection='{{$1}}'",
               description: nil,
               options: [
                Option(name: "Name",
                       placeholder: "Action Name",
                       defaultText: "Open Collection",
                       helpText: nil
                ),
                Option(name: "Collection",
                       placeholder: "Collection Name",
                       defaultText: "Found while reading",
                       helpText: nil
                )]
        ),
        Action(labelName: "Search",
               actionName: "Search",
               url: "lookupapp://?search={{$1}}",
               description: nil,
               options: [
                Option(name: "Name",
                       placeholder: "Action Name",
                       defaultText: "Search",
                       helpText: nil
                ),
                Option(name: "Query",
                       placeholder: "",
                       defaultText: "[prompt:Query]",
                       helpText: nil
                )]
        )]
    )
    //
    //"Goodreads",
//"Basmo",
//"BookBuddy",
//"BookSloth",
//"Italic Type",
//
//"Notes",
//"Obsidian",
//"Drafts",
//"Tot",
//"Voice Memos",
//"Evernote",
//"MindNode",
//
//"Shortcuts",
//"Toggl",
//"Dark Noise",
//"Spotify",
//"Apple Music",
//
//"Prologue",
//"Audible",
//"Audiobooks",
//"Overdrive",
//"Libby",
//"Books",
//"Kindle",
//"BookFusion",
//"Barnes & Noble",
//"Hyphen",
//
//"Slack",
//"Discord",
//
//"OmniFocus",
//"Things",
//"Todoist",
//"Reminders",
//"Trello"
]

struct LinkComposerView: View {
    @Binding var url: String
    @EnvironmentObject private var linkComposer: LinkComposer
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        List {
            ForEach(apps, id: \.appName) { app in
                if app.actions.count == 1 {
                    HStack {
                        Text(app.appName)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        linkComposer.set(url: app.actions[0].url, actionName: app.actions[0].actionName)
                    }
                } else if app.actions.count > 1 {
                    NavigationLink(
                        destination: LinkComposerActionsView(appName: app.appName, actions: app.actions),
                        label: {
                            Text(app.appName)
                        })
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Apps")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Cancel")
        })
    }
}

struct LinkComposerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LinkComposerView(url: .constant(""))
                .environmentObject(LinkComposer())
        }
    }
}
