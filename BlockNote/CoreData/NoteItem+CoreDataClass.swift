//
//  NoteItem+CoreDataClass.swift
//  BlockNote
//
//  Created by Kovs on 08.09.2021.
//
//

import Foundation
import CoreData

// @objc(NoteItem

enum NoteItemType: Int {
    case textBlock
    case vocabularyBlock
    case countDownBlock
    case emptyBlockTest
    // and so on
}

public class NoteItem: NSManagedObject {
    @NSManaged var noteItemOrder: Int
    // @NSManaged fileprivate var noteTypeValue: Int
    @NSManaged fileprivate var noteItemType: Int
    
    var type: NoteItemType {
        get {
            return NoteItemType(rawValue: noteItemType) ?? .emptyBlockTest
        }
        set {
            noteItemType = newValue.rawValue
        }
    }
}
