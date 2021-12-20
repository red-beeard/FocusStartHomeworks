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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case age
        case experience
    }
    
    init(employee: Employee) {
        self.id = employee.id
        self.name = employee.name
        self.age = Int(employee.age)
        self.experience = employee.experience?.intValue
    }
    
    init(id: UUID, name: String, age: Int, experience: Int? = nil) {
        self.id = id
        self.name = name
        self.age = age
        self.experience = experience
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.experience = try? container.decode(Int.self, forKey: .experience)
    }
}
