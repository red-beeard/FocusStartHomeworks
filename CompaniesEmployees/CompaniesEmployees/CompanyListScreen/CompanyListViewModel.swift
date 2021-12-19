//
//  CompanyListViewModel.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

import Foundation

struct CompanyListViewModel {
    let name: String
    let id: UUID
    
    init(company: CompanyDTO) {
        self.id = company.id
        self.name = company.name
    }
}
