//
//  Company+CoreDataProperties.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 20.12.2021.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var employees: NSSet?

}

// MARK: Generated accessors for employees
extension Company {

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: Employee)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: Employee)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}

extension Company : Identifiable {

}

extension Company {
    
    func setValues(from company: CompanyDTO) {
        self.id = company.id
        self.name = company.name
    }
    
}
