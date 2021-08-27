//
//  BookView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 7/30/21.
//

import SwiftUI

struct BookView: View {
    @State var book: BookStruct
    @Binding var isSelected: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack() {
                Text(book.title)
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            .frame(height: 100)
            .background(Color("LightBackground"))
            if(isSelected) {
                HStack() {
                    Spacer()
                    ForEach(book.links, id: \.url) { link in
                        Image(systemName: link.icon)
                            .font(.system(size: 28, weight: .regular))
                            .onTapGesture {
                                UIApplication.shared.open(URL(string: link.url)!)
                            }
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .frame(height: 70)
                .background(Color("Background"))
            }
        }
        .animation(.easeInOut)
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        let book1 = BookStruct(title: "The Path of Daggers", links:
                            [
                                BookLink(icon: "timer", url: "shortcuts://run-shortcut?name=Start%20Reading%20Timer&input=The%20Path%20of%20Daggers"),
                             BookLink(icon: "g.square.fill", url: "https://www.goodreads.com/book/show/140974.The_Path_of_Daggers"),
                             BookLink(icon: "drop.fill", url: "obsidian://open?vault=Notes&file=001%20Literature%20Notes%2FBook%2FThe%20Path%20of%20Daggers")
                            ])
        let book2 = BookStruct(title: "The Problem of Pain", links:
                            [
                                BookLink(icon: "timer", url: "shortcuts://run-shortcut?name=Start%20Reading%20Timer&input=The%20Problem%20of%20Pain"),
                                BookLink(icon: "g.square.fill", url: "https://www.goodreads.com/book/show/13650513-the-problem-of-pain"),
                                BookLink(icon: "drop.fill", url: "obsidian://open?vault=Notes&file=001%20Literature%20Notes%2FBook%2FThe%20Problem%20of%20Pain"),
                                BookLink(icon: "rays", url: "mindnode://open?name=The%20Problem%20of%20Pain.mindnode"),
                                BookLink(icon: "headphones", url: "https://www.orbit.fm/imprint/13"),
                                BookLink(icon: "dot.radiowaves.left.and.right", url: "https://overcast.fm/+bjLPlPLys")
                         ])
        VStack {
            BookView(book: book1, isSelected: .constant(true))
            BookView(book: book2, isSelected: .constant(false))
        }
            .preferredColorScheme(.dark)
        
        BookView(book: book2, isSelected: .constant(true))
    }
}
