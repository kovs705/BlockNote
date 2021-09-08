//
//  NoteItem+CoreDataProperties.swift
//  BlockNote
//
//  Created by Kovs on 08.09.2021.
//
//

import Foundation
import CoreData


extension NoteItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteItem> {
        return NSFetchRequest<NoteItem>(entityName: "NoteItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var text: String?
    @NSManaged public var order: Int16
    @NSManaged public var note: Note?

}

extension NoteItem : Identifiable {

}
