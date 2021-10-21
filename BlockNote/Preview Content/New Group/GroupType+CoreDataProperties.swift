//
//  GroupType+CoreDataProperties.swift
//  BlockNote
//
//  Created by Kovs on 07.10.2021.
//
//

import Foundation
import CoreData


extension GroupType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupType> {
        return NSFetchRequest<GroupType>(entityName: "GroupType")
    }

    @NSManaged public var number: Int64
    @NSManaged public var color: String?
    @NSManaged public var name: String?
    @NSManaged public var noteTypes: Note?

}

extension GroupType : Identifiable {

}
