//
//  Note+CoreDataClass.swift
//  BlockNote
//
//  Created by Kovs on 08.09.2021.
//
//

import Foundation
import CoreData

// @objc(Note)
public class Note: NSManagedObject {
    @NSManaged var noteID: Int
}
