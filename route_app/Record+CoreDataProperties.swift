//
//  Record+CoreDataProperties.swift
//  task2.2
//
//  Created by Elizaveta on 5/15/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var availability: Bool
    @NSManaged public var busStation: String?
    @NSManaged public var cityFrom: String?
    @NSManaged public var cityTo: String?
    @NSManaged public var price: Float

}
