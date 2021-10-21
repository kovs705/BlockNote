//
//  ItemList+CoreDataProperties.swift
//  BlockNote
//
//  Created by Kovs on 07.10.2021.
//
//

import Foundation
import CoreData


extension ItemList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemList> {
        return NSFetchRequest<ItemList>(entityName: "ItemList")
    }

    @NSManaged public var row: Int64
    @NSManaged public var translation: String?
    @NSManaged public var word: String?

}

extension ItemList : Identifiable {

}
