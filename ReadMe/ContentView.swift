//
//  ContentView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 4/19/21.
//

import SwiftUI

struct ContentView: View {
    @State var selectedIndex: Int = -1
    
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
        VStack(spacing: 0) {
            BookView(book: book1, isSelected: Binding<Bool>(
                        get: {
                            self.selectedIndex == 0
                            
                        },
                        set: {  newValue in
                            self.selectedIndex = -1
                
                        }
            ))
                .onTapGesture {
                    selectedIndex = selectedIndex == 0 ? -1 : 0
                }
            BookView(book: book2,  isSelected: Binding<Bool>(
                get: {
                    self.selectedIndex == 1
                    
                },
                set: {  newValue in
                    self.selectedIndex = -1
        
                }
    ))
                .onTapGesture {
                    selectedIndex = selectedIndex == 1 ? -1 : 1
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
