//
//  NetworkService.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 18.12.2021.
//

import Foundation

protocol INetworkService: IDataService {
//    func getAllCompanies() throws -> [CompanyDTO]
//    func getEmployees(from company: CompanyDTO) throws -> [EmployeeDTO]
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
    
    func delete(company: CompanyDTO) throws -> CompanyDTO? {
        if let path = Bundle.main.url(forResource: "Companies", withExtension: "json") {
            let data = try Data(contentsOf: path)
            
            var companies = try JSONDecoder().decode([CompanyDTO].self, from: data)
            companies.removeAll { $0.id == company.id }
            let newCompaniesData = try JSONEncoder().encode(companies)
            let jsonString = String(decoding: newCompaniesData, as: UTF8.self)
            try jsonString.write(to: path, atomically: true, encoding: .utf8)
            return company
        }
        return nil
    }
    
    func delete(employee: EmployeeDTO, from company: CompanyDTO) throws -> EmployeeDTO? {
        if let path = Bundle.main.url(forResource: "\(company.id)", withExtension: "json") {
            let data = try Data(contentsOf: path)
            
            var employees = try JSONDecoder().decode([EmployeeDTO].self, from: data)
            employees.removeAll { $0.id == employee.id }
            let newEmployeesData = try JSONEncoder().encode(employees)
            let jsonString = String(decoding: newEmployeesData, as: UTF8.self)
            try jsonString.write(to: path, atomically: true, encoding: .utf8)
            return employee
        }
        return nil
    }
    
    func add(company: CompanyDTO) throws {
        if let path = Bundle.main.url(forResource: "Companies", withExtension: "json") {
            let data = try Data(contentsOf: path)
            
            var companies = try JSONDecoder().decode([CompanyDTO].self, from: data)
            companies.append(company)
            
            let newCompaniesData = try JSONEncoder().encode(companies)
            let jsonString = String(decoding: newCompaniesData, as: UTF8.self)
            try jsonString.write(to: path, atomically: true, encoding: .utf8)
        }
    }
    
}
