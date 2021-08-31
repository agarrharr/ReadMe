//
//  LinkComposer.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/30/21.
//

import Foundation

class LinkComposer: ObservableObject {
    var action: Action?
    @Published var isPresenting = false
    @Published var url: String
    @Published var actionName: String
    @Published var optionValues: [String]
    
    init() {
        url = ""
        actionName = ""
        optionValues = []
    }
    
    func setAction(action: Action) {
        self.action = action
        
        if let options = action.options {
            optionValues = Array(repeating: "", count: options.count)
        } else {
            optionValues = []
        }
    }
    
    func set(url: String, actionName: String) {
        self.url = url
        self.actionName = actionName
        
        isPresenting = false
    }
    
    func updateURL() {
        if url == "" {
            self.url = "I'm updated"
            
            // lookupapp://?collection='{{$1}}'&name={{$2}}
            // ["lookupapp://?collection='{{", "$1", "}}'&name={{", "$2", "}}"]
        }
        isPresenting = false
    }
}
