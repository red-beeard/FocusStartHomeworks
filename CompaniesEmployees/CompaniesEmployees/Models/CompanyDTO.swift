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
}

extension CompanyDTO: CustomStringConvertible {
    
    var description: String {
        "\(name) - \(id)"
    }
    
}
