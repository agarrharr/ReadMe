//
//  Link+CoreDataProperties.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/27/21.
//
//

import Foundation
import CoreData


extension Link {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Link> {
        return NSFetchRequest<Link>(entityName: "Link")
    }

    @NSManaged public var url: String?
    @NSManaged public var name: String?
    @NSManaged public var symbolName: String?
    @NSManaged public var book: Book?
    
    static func createWith(url: String, name: String, systemName: String, in context: NSManagedObjectContext) -> Link {
        let link = Link(context: context)

        link.url = url
        link.name = name
        link.symbolName = systemName

        do {
            try context.save()
        } catch {
            fatalError("Unresolved error \(error)")
        }

        return link
    }
}

extension Link : Identifiable {

}
