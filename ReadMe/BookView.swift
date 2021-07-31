//
//  BookView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 7/30/21.
//

import SwiftUI

struct BookView: View {
    @State var book: Book
    @State var index: Int
    @State var isShowingButtons: Bool
    
    @ObservedObject private var model = BookModel()
    
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
            .onTapGesture {
                model.selectedIndex = index
            }
            if(isShowingButtons) {
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
    }
}

struct BookView_Previews: PreviewProvider {
   
    static var previews: some View {
        let book = Book(title: "The Path of Daggers", links:
                            [
                                BookLink(icon: "timer", url: "shortcuts://run-shortcut?name=Start%20Reading%20Timer&input=The%20Path%20of%20Daggers"),
                             BookLink(icon: "g.square.fill", url: "https://www.goodreads.com/book/show/140974.The_Path_of_Daggers"),
                             BookLink(icon: "drop.fill", url: "obsidian://open?vault=Notes&file=001%20Literature%20Notes%2FBook%2FThe%20Path%20of%20Daggers")
                            ]
                        )
        
        BookView(book: book, index: 0, isShowingButtons: true)
            .preferredColorScheme(.dark)
        BookView(book: book, index: 1, isShowingButtons: false)
    }
}
