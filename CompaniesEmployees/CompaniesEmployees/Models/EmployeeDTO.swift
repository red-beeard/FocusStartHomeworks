//
//  EmployeeDTO.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

import Foundation

struct EmployeeDTO: Codable {
    let id: UUID
    let name: String
    let age: Int
    let experience: Int?
    
    init(employee: Employee) {
        self.id = employee.id
        self.name = employee.name
        self.age = Int(employee.age)
        self.experience = employee.experience?.intValue
    }
}
