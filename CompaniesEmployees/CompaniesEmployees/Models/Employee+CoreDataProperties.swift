//
//  Employee+CoreDataProperties.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 20.12.2021.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var age: Int16
    @NSManaged public var experience: NSNumber?
    @NSManaged public var company: Company

}

extension Employee : Identifiable {

}
