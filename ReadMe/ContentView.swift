//
//  ContentView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 4/19/21.
//

import SwiftUI

struct ContentView: View {
    var activeBook: Int = -1
    
    let book1 = Book(title: "The Path of Daggers", links:
                        [
                            BookLink(icon: "timer", url: "shortcuts://run-shortcut?name=Start%20Reading%20Timer&input=The%20Path%20of%20Daggers"),
                         BookLink(icon: "g.square.fill", url: "https://www.goodreads.com/book/show/140974.The_Path_of_Daggers"),
                         BookLink(icon: "drop.fill", url: "obsidian://open?vault=Notes&file=001%20Literature%20Notes%2FBook%2FThe%20Path%20of%20Daggers")
                        ])
    let book2 = Book(title: "The Problem of Pain", links:
                        [
                            BookLink(icon: "timer", url: "shortcuts://run-shortcut?name=Start%20Reading%20Timer&input=The%20Problem%20of%20Pain"),
                            BookLink(icon: "g.square.fill", url: "https://www.goodreads.com/book/show/13650513-the-problem-of-pain"),
                            BookLink(icon: "drop.fill", url: "obsidian://open?vault=Notes&file=001%20Literature%20Notes%2FBook%2FThe%20Problem%20of%20Pain"),
                            BookLink(icon: "rays", url: "mindnode://open?name=The%20Problem%20of%20Pain.mindnode"),
                            BookLink(icon: "headphones", url: "https://www.orbit.fm/imprint/13"),
                            BookLink(icon: "dot.radiowaves.left.and.right", url: "https://overcast.fm/+bjLPlPLys")
                     ])
    
    var body: some View {
        VStack {
            BookView(book: book1, isShowingButtons: true)
            BookView(book: book2, isShowingButtons: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
