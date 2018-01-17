//
//  DBUpperTable+CoreDataProperties.swift
//  Wardrobe
//
//  Created by Sanjay Mali on 17/01/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//
//

import Foundation
import CoreData


extension DBUpperTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBUpperTable> {
        return NSFetchRequest<DBUpperTable>(entityName: "DBUpperTable")
    }

    @NSManaged public var upper_favouite: Bool
    @NSManaged public var upper_id: Int16
    @NSManaged public var upper_upperImage: NSObject?

}
