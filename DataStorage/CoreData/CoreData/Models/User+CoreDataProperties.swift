//
//  User+CoreDataProperties.swift
//  DataStorage
//
//  Created by Mustafa Bekirov on 31.03.2023.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var age: Int16
    @NSManaged public var name: String?
    @NSManaged public var isMain: Bool
    @NSManaged public var anyBool: NSNumber?
    @NSManaged public var company: Company?

}

extension User : Identifiable {

}
