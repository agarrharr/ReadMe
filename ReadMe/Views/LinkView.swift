//
//  LinkView.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/31/21.
//

import SwiftUI

struct LinkView: View {
    var link: Link
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: link.symbolName ?? "link")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "ellipsis.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .foregroundColor(.white)
                    .foregroundColor(.white)
            }
            .padding(.vertical, 1)
            
            Text(link.name ?? "")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
        .frame(height: 90)
        .padding(12)
        .background(Color(.systemPurple))
        .cornerRadius(10)
        .onTapGesture {
            print(link.url ?? "")
            UIApplication.shared.open(URLUtility.convertToURL(link.url ?? ""))
        }
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let link = Link(context: context)
        link.url = "http://google.com"
        link.name = "Google"
        link.symbolName = "link"
        
        return LinkView(link: link)
    }
}
