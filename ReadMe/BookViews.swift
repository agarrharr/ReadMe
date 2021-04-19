//
//  BookViews.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 4/19/21.
//

import SwiftUI

extension Book {
    struct Image: View {
        let title: String
        
        var body: some View {
            let symbol = SwiftUI.Image(title: title)
                ?? .init(systemName: "book")
                
            symbol
                .resizable()
                .scaledToFit()
                .frame(width: 80, height:80)
                .font(Font.title.weight(.light))
                .foregroundColor(.secondary)
        }
    }
}

struct Book_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Book.Image(title: Book().title)
            Book.Image(title: "Gone With the Wind")
            Book.Image(title: "")
            Book.Image(title: "😜")
        }
    }
}

extension Image {
    init?(title: String) {
        guard let character = title.first,
              case let symbolName = "\(character.lowercased()).square",
              UIImage(systemName: symbolName) != nil
        else {
            return nil
        }
        
        self.init(systemName: symbolName)
    }
}
