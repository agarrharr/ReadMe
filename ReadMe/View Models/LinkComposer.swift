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
    @Published var optionValues: [String]
    
    init() {
        self.url = ""
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
    
    func updateURL() {
        // TODO: actually construct the URL
        url = "I'm updated"
        isPresenting = false
    }
}
