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

    @NSManaged public var noteItemName: String?
    @NSManaged public var NoteItemText: String?
    @NSManaged public var noteItemOrder: Int
    
    @NSManaged public var note: Note?
    
    public var wrappedNoteItemName: String {
        noteItemName ?? "Unknown NoteItem name"
    }
    public var wrappedNoteItemText: String {
        NoteItemText ?? "Unknown text"
    }
    public var wrappedNoteItemOrder: Int {
        noteItemOrder
    }

}

extension NoteItem : Identifiable {

}
