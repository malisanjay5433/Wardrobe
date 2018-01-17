//
//  DBLowerTable+CoreDataProperties.swift
//  Wardrobe
//
//  Created by Sanjay Mali on 17/01/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//
//

import Foundation
import CoreData


extension DBLowerTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBLowerTable> {
        return NSFetchRequest<DBLowerTable>(entityName: "DBLowerTable")
    }

    @NSManaged public var lower_favouite: Bool
    @NSManaged public var lower_id: Int16
    @NSManaged public var lowerImage: NSObject?

}
