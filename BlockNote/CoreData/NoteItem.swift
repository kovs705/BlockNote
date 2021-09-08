//
//  ListItem.swift
//  BlockNote
//
//  Created by Kovs on 08.09.2021.
//

import CoreData

class NoteItem: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var order: Int
    @NSManaged var level: String
    
    
}


