//
//  Note+CoreDataProperties.swift
//  BlockNote
//
//  Created by Kovs on 08.09.2021.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var name: String?
    @NSManaged public var level: String?
    @NSManaged public var type: String?
    @NSManaged public var noteItems: NSSet?

    
    
}

// MARK: Generated accessors for noteItems
extension Note {

    @objc(addNoteItemsObject:)
    @NSManaged public func addToNoteItems(_ value: NoteItem)

    @objc(removeNoteItemsObject:)
    @NSManaged public func removeFromNoteItems(_ value: NoteItem)

    @objc(addNoteItems:)
    @NSManaged public func addToNoteItems(_ values: NSSet)

    @objc(removeNoteItems:)
    @NSManaged public func removeFromNoteItems(_ values: NSSet)

}

extension Note : Identifiable {

}
