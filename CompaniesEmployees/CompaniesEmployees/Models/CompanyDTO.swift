//
//  CompanyDTO.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import Foundation

struct CompanyDTO: Codable {
    let id: UUID
    let name: String
    
    init(company: Company) {
        self.id = company.id
        self.name = company.name
    }
    
    init(name: String) {
        self.name = name
        self.id = UUID()
    }
}

extension CompanyDTO: CustomStringConvertible {
    
    var description: String {
        "\(name) - \(id)"
    }
    
}
