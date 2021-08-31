//
//  LinkComposer.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/30/21.
//

import Foundation

class LinkComposer: ObservableObject {
    var action: Action?
    @Published var isPresenting: Bool
    @Published var url: String
    @Published var actionName: String
    @Published var optionValues: [String]
    
    init() {
        isPresenting = false
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
        if url == "" && action != nil {
            // TODO: extract to a helper function that is unit tested
            
            self.url = optionValues.enumerated().map { ($0, $1) }
                .reduce(action!.url, { (accum, value) in
                accum.replacingOccurrences(of: "$\(value.0)", with: value.1)
            })
        }
        isPresenting = false
    }
}
