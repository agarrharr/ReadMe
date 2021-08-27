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

    static func createWith(title: String, using viewContext: NSManagedObjectContext) {
        let book = Book(context: viewContext)
        print("Make book with context")
        book.title = title

        do {
            try viewContext.save()
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
    
    static func basicFetchRequest() -> FetchRequest<Book> {
        FetchRequest(entity: Book.entity(), sortDescriptors: [])
    }
}

extension Book : Identifiable {

}
