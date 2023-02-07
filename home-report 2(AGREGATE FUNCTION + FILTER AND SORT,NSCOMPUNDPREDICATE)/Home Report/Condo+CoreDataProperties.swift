//
//  Condo+CoreDataProperties.swift
//  Home Report
//
//  Created by Andi Setiyadi on 6/8/18.
//  Copyright © 2018 devhubs. All rights reserved.
//
//

import Foundation
import CoreData


extension Condo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Condo> {
        return NSFetchRequest<Condo>(entityName: "Condo")
    }

    @NSManaged public var unitsPerBuilding: Int16

}
