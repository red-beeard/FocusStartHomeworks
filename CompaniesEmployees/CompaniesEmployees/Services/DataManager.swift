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
    func delete(company: CompanyDTO, completion: @escaping (Result<CompanyDTO?, Error>) -> Void)
    func delete(employee: EmployeeDTO, from company: CompanyDTO, completion: @escaping (Result<EmployeeDTO?, Error>) -> Void)
    func add(company: CompanyDTO, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol IDataService {
    func getAllCompanies() throws -> [CompanyDTO]
    func getEmployees(from company: CompanyDTO) throws -> [EmployeeDTO]
    func delete(company: CompanyDTO) throws -> CompanyDTO?
    func delete(employee: EmployeeDTO, from company: CompanyDTO) throws -> EmployeeDTO?
    func add(company: CompanyDTO) throws
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
    
    private func delete(company: CompanyDTO, from service: IDataService, completion: @escaping (Result<CompanyDTO?, Error>) -> Void) {
        let deadline = DispatchTime.now() + (service is NetworkService ? 5 : 0)
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: deadline) {
            do {
                let company = try service.delete(company: company)
                completion(.success(company))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func delete(employee: EmployeeDTO, from company: CompanyDTO, from service: IDataService, completion: @escaping (Result<EmployeeDTO?, Error>) -> Void) {
        let deadline = DispatchTime.now() + (service is NetworkService ? 5 : 0)
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: deadline) {
            do {
                let company = try service.delete(employee: employee, from: company)
                completion(.success(company))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func add(company: CompanyDTO, from service: IDataService, completion: @escaping (Result<Void, Error>) -> Void) {
        let deadline = DispatchTime.now() + (service is NetworkService ? 5 : 0)
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: deadline) {
            do {
                try service.add(company: company)
                completion(.success(()))
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
    
    func delete(company: CompanyDTO, completion: @escaping (Result<CompanyDTO?, Error>) -> Void) {
        self.delete(company: company, from: self.coreDataManager, completion: completion)
        self.delete(company: company, from: self.networkService, completion: completion)
    }
    
    func delete(employee: EmployeeDTO, from company: CompanyDTO, completion: @escaping (Result<EmployeeDTO?, Error>) -> Void) {
        self.delete(employee: employee, from: company, from: self.coreDataManager, completion: completion)
        self.delete(employee: employee, from: company, from: self.networkService, completion: completion)
    }
    
    func add(company: CompanyDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        self.add(company: company, from: self.coreDataManager, completion: completion)
        self.add(company: company, from: self.networkService, completion: completion)
    }
    
}
