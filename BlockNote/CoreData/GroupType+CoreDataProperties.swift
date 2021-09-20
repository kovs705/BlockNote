//
//  GroupType+CoreDataProperties.swift
//  BlockNote
//
//  Created by Kovs on 20.09.2021.
//
//

import Foundation
import CoreData


extension GroupType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupType> {
        return NSFetchRequest<GroupType>(entityName: "GroupType")
    }

    @NSManaged public var name: String?
    @NSManaged public var color: String?

}

extension GroupType : Identifiable {

}
