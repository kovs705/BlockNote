//
//  GroupType+CoreDataClass.swift
//  BlockNote
//
//  Created by Kovs on 20.09.2021.
//
//

import Foundation
import CoreData

@objc(GroupType)
public class GroupType: NSManagedObject {
    @NSManaged var number: Int
}
