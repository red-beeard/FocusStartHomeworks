//
//  EditEmployeeViewModel.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 22.12.2021.
//

struct EditEmployeeViewModel {
    let name: String?
    let age: String?
    let experience: String?
    
    init(name: String? = nil, age: String? = nil, experience: String? = nil) {
        self.name = name
        self.age = age
        self.experience = experience
    }
    
    init(employee: EmployeeDTO) {
        self.name = employee.name
        self.age = String(employee.age)
        
        if let experience = employee.experience {
            self.experience = String(experience)
        } else {
            self.experience = nil
        }
    }
}
