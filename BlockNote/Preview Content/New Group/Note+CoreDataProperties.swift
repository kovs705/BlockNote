//
//  Note+CoreDataProperties.swift
//  BlockNote
//
//  Created by Kovs on 07.10.2021.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var noteID: Int64
    @NSManaged public var level: String?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var isMarked: Bool
    @NSManaged public var typeOfNote: GroupType?
    @NSManaged public var noteItems: NoteItem?

}

extension Note : Identifiable {

}
