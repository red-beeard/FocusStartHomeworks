//
//  EmployeesScreenViewModel.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 20.12.2021.
//

import Foundation

struct EmployeesScreenViewModel {
    let id: UUID
    let name: String
    let age: Int
    let experience: Int?
    
    init(employee: EmployeeDTO) {
        self.id = employee.id
        self.name = employee.name
        self.age = employee.age
        self.experience = employee.experience
    }
}
