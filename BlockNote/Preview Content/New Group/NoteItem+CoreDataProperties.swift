//
//  NoteItem+CoreDataProperties.swift
//  BlockNote
//
//  Created by Kovs on 07.10.2021.
//
//

import Foundation
import CoreData


extension NoteItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteItem> {
        return NSFetchRequest<NoteItem>(entityName: "NoteItem")
    }

    @NSManaged public var order: Int64
    @NSManaged public var itemType: String?
    @NSManaged public var name: String?
    @NSManaged public var text: String?
    @NSManaged public var note: Note?

}

extension NoteItem : Identifiable {

}
