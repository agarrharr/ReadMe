//
//  Book+CoreDataProperties.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/27/21.
//
//

import Foundation
import CoreData
import SwiftUI

extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var title: String
    @NSManaged public var isbn: String
    @NSManaged public var links: NSSet?
    
    public var linkArray: [Link] {
        let set = links as? Set<Link> ?? []
        
        return set.sorted {
            ($0.url ?? "") < ($1.url ?? "")
        }
    }
    
    static func createWith(title: String, links: [Link], in context: NSManagedObjectContext) {
        let book = Book(context: context)

        book.title = title
        book.links = NSSet(array: links)

        do {
            try context.save()
        } catch {
            fatalError("Error saving book: \(error)")
        }
    }
    
//    static func createWith(title: String, isbn: String, links: [Link], in context: NSManagedObjectContext) {
//        let book = Book(context: context)
//
//        book.title = title
//        book.isbn = isbn
//        book.links = NSSet(array: links)
//
//        do {
//            try context.save()
//        } catch {
//            fatalError("Error saving book: \(error)")
//        }
//    }
    
    func add(link: Link, in context: NSManagedObjectContext) {
        self.links = NSSet(array: self.linkArray + [link])

        do {
            try context.save()
        } catch {
            fatalError("Error saving book: \(error)")
        }
    }
    
    func delete(book: Book, in context: NSManagedObjectContext) {
        context.delete(book)
        
        do {
            try context.save()
        } catch {
            fatalError("Error deleting book: \(error)")
        }
    }
    
    static func basicFetchRequest() -> FetchRequest<Book> {
        FetchRequest(entity: Book.entity(), sortDescriptors: [])
    }
}

extension Book : Identifiable {

}
