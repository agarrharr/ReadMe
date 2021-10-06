//
//  URL.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 10/6/21.
//

import Foundation

class URLUtility {
    public static func convertToURL(_ path: String) -> URL {
        let pathCSV = path.replacingOccurrences(of: "{{", with: ",").replacingOccurrences(of: "}}", with: ",")
        let pathArray = pathCSV.components(separatedBy: ",")

        var encodedPath = ""
        pathArray.indices.forEach { i in
            if pathArray[i] != "" {
                if i % 2 == 0 {
                    encodedPath += pathArray[i]
                } else {
                    encodedPath += pathArray[i].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? pathArray[i]
                }
            }
        }
        
        if let url = URL(string: encodedPath) {
            return url
        }
        return URL(string: "")!
    }
}
