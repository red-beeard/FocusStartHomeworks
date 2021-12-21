//
//  DataManager.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import Foundation

protocol IDataManager {
    func getCompanies(completion: @escaping (Result<[CompanyDTO], Error>) -> Void)
    func getEmployees(from company: CompanyDTO, completion: @escaping (Result<[EmployeeDTO], Error>) -> Void) 
}

protocol IDataService {
    func getAllCompanies() throws -> [CompanyDTO]
    func getEmployees(from company: CompanyDTO) throws -> [EmployeeDTO]
}

final class DataManager {
    
    static let shared = DataManager()
    
    private init() { }
    
    private let coreDataManager: IDataService = CoreDataManager()
    private let networkService: IDataService = NetworkService()
    
    private func getCompanies(from service: IDataService, completion: @escaping (Result<[CompanyDTO], Error>) -> Void) {
        let deadline = DispatchTime.now() + (service is NetworkService ? 5 : 0)
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: deadline) {
            do {
                let companies = try service.getAllCompanies()
                completion(.success(companies))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func getEmployees(from service: IDataService, with company: CompanyDTO, completion: @escaping (Result<[EmployeeDTO], Error>) -> Void) {
        let deadline = DispatchTime.now() + (service is NetworkService ? 5 : 0)
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: deadline) {
            do {
                let employees = try service.getEmployees(from: company)
                completion(.success(employees))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
}

extension DataManager: IDataManager {
    
    func getCompanies(completion: @escaping (Result<[CompanyDTO], Error>) -> Void) {
        self.getCompanies(from: self.coreDataManager, completion: completion)
        self.getCompanies(from: self.networkService, completion: completion)
    }
    
    func getEmployees(from company: CompanyDTO, completion: @escaping (Result<[EmployeeDTO], Error>) -> Void) {
        self.getEmployees(from: self.coreDataManager, with: company, completion: completion)
        self.getEmployees(from: self.networkService, with: company, completion: completion)
    }
    
}
