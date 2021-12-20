//
//  NetworkService.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 18.12.2021.
//

import Foundation

protocol INetworkService {
    func getAllCompanies() throws -> [CompanyDTO]
    func getEmployees(from company: CompanyDTO) throws -> [EmployeeDTO]
}

final class NetworkService {
    
    private func printJsonData(_ data: Data?) {
        if let data = data {
            print(String(decoding: data, as: UTF8.self))
        }
    }
    
}

extension NetworkService: INetworkService {
    
    func getAllCompanies() throws -> [CompanyDTO] {
        if let path = Bundle.main.url(forResource: "Companies", withExtension: "json") {
            let data = try Data(contentsOf: path)
//            self.printJsonData(data)
            
            return try JSONDecoder().decode([CompanyDTO].self, from: data)
        }
        return []
    }
    
    func getEmployees(from company: CompanyDTO) throws -> [EmployeeDTO] {
        if let path = Bundle.main.url(forResource: "\(company.id)", withExtension: "json") {
            let data = try Data(contentsOf: path)
//            self.printJsonData(data)
            
            return try JSONDecoder().decode([EmployeeDTO].self, from: data)
        }
        return []
    }
}
