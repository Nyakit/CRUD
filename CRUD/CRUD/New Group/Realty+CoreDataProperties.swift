//
//  Realty+CoreDataProperties.swift
//  CRUD
//
//  Created by Пользователь on 19.02.2018.
//  Copyright © 2018 Kyle Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension Realty {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Realty> {
        return NSFetchRequest<Realty>(entityName: "Realty")
    }

    @NSManaged public var accountid: String?
    @NSManaged public var addres: String?
    @NSManaged public var area: Double
    @NSManaged public var countOfRooms: Int16
    @NSManaged public var floor: Int16
    @NSManaged public var price: Double
    @NSManaged public var prisePerSquareMeters: Double

}
