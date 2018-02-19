//
//  Account+CoreDataProperties.swift
//  Saving Data BayBeh
//
//  Created by Пользователь on 18.02.2018.
//  Copyright © 2018 Kyle Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var login: String?
    @NSManaged public var password: String?
    @NSManaged public var status: Bool

}
