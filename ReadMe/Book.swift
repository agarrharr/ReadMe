//
//  Book.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 4/19/21.
//

import Combine

struct Book {
    let title: String
    let links: [BookLink]
    
    init(title: String = "Title", links: [BookLink] = []) {
        self.title = title
        self.links = links
    }
}

struct BookLink {
    let icon: String
    let url: String
    
    init(icon: String = "link", url: String = "") {
        self.icon = icon
        self.url = url
    }
}
