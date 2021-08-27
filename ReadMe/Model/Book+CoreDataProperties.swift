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
    @NSManaged public var links: NSSet?
    
    public var linkArray: [Link] {
        let set = links as? Set<Link> ?? []
        
        return set.sorted {
            ($0.url ?? "") < ($1.url ?? "")
        }
    }

//    static func create(withTitle title: String, in context: NSManagedObjectContext) {
//        let book = Book(context: context)
//
//        book.title = title
//
//        do {
//            try context.save()
//        } catch {
//            fatalError("Unresolved error \(error)")
//        }
//    }
    
    static func createWith(title: String, links: [Link], in context: NSManagedObjectContext) -> Book {
        let book = Book(context: context)

        book.title = title
    
        book.links = NSSet(array: links)

        do {
            try context.save()
        } catch {
            fatalError("Error saving book: \(error)")
        }
        
        return book
    }
    
    static func basicFetchRequest() -> FetchRequest<Book> {
        FetchRequest(entity: Book.entity(), sortDescriptors: [])
    }
}

extension Book : Identifiable {

}
