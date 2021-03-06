//
//  Image.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/29/21.
//

import SwiftUI

extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        
        return self
            .resizable()
    }
}
