//
//  GroupType+CoreDataProperties.swift
//  BlockNote
//
//  Created by Kovs on 20.09.2021.
//
//

import Foundation
import CoreData


extension GroupType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupType> {
        return NSFetchRequest<GroupType>(entityName: "GroupType")
    }

    @NSManaged public var name: String?
    @NSManaged public var color: String?
    @NSManaged public var noteTypes: NSSet?
    
    public var wrappedNumber: Int {
        number
    }
    
    public var typesArray: [Note] {
        let set = noteTypes as? Set<Note> ?? []
        return set.sorted {
            $0.wrappedType < $1.wrappedType
        }
    }
}

// MARK: Generated accessors for Note
extension Note {

    @objc(addNoteObject:)
    @NSManaged public func addToNote(_ value: Note)

    @objc(removeNoteObject:)
    @NSManaged public func removeFromNote(_ value: Note)

    @objc(addNote:)
    @NSManaged public func addToNote(_ values: NSSet)

    @objc(removeNote:)
    @NSManaged public func removeFromNote(_ values: NSSet)

}

extension GroupType : Identifiable {

}
