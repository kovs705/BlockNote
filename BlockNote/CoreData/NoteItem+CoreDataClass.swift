//
//  NoteItem+CoreDataClass.swift
//  BlockNote
//
//  Created by Kovs on 08.09.2021.
//
//

import Foundation
import CoreData


public class NoteItem: NSManagedObject {
    @NSManaged var noteItemOrder: Int
    // @NSManaged fileprivate var noteTypeValue: Int
    // @NSManaged var noteItemType: Int
    
//    var type: NoteItemType {/Users/pk/Documents/BigPP/BlockNote app/BlockNote app/CoreData/Note/Note+CoreDataClass.swift
//        get {
//            return NoteItemType(rawValue: noteItemType) ?? .emptyBlockTest
//        }
//        set {
//            noteItemType = newValue.rawValue
//        }
//    }
}
