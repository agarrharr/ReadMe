//
//  BookView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 7/30/21.
//

import SwiftUI

struct BookView: View {
    @State var book: Book
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
                    ForEach(book.linkArray, id: \.url) { link in
                        Image(systemName: link.symbolName!)
                            .font(.system(size: 28, weight: .regular))
                            .onTapGesture {
                                UIApplication.shared.open(URL(string: link.url!)!)
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
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let link1 = Link.createWith(url: "asdf://", systemName: "checkmark", in: context)
        let book1 = Book.createWith(title: "Book", links: [link1], in: context)
        let book2 = Book.createWith(title: "Book 2", links: [], in: context)

        VStack {
            BookView(book: book1, isSelected: .constant(true))
            BookView(book: book2, isSelected: .constant(false))
        }
            .preferredColorScheme(.dark)
        
        BookView(book: book2, isSelected: .constant(true))
            .environment(\.managedObjectContext, context)
    }
}
