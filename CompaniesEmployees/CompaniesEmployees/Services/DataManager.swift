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
    func add(employee: EmployeeDTO, to company: CompanyDTO, completion: @escaping (Result<Void, Error>) -> Void)
    func update(employee: EmployeeDTO, from company: CompanyDTO, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol IDataService {
    func getAllCompanies() throws -> [CompanyDTO]
    func getEmployees(from company: CompanyDTO) throws -> [EmployeeDTO]
    func delete(company: CompanyDTO) throws -> CompanyDTO?
    func delete(employee: EmployeeDTO, from company: CompanyDTO) throws -> EmployeeDTO?
    func add(company: CompanyDTO) throws
    func add(to company: CompanyDTO, employee: EmployeeDTO) throws
    func update(from company: CompanyDTO, employee: EmployeeDTO) throws
}

final class DataManager {
    
    static let shared = DataManager()
    
    private init() { }
    
    private let coreDataManager: ICoreDataService = CoreDataService()
    private let networkService: IDataService = NetworkService()
    
}

extension DataManager: IDataManager {
    
    func getCompanies(completion: @escaping (Result<[CompanyDTO], Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let coreDataCompanies = try self.coreDataManager.getAllCompanies()
                completion(.success(coreDataCompanies))
                sleep(5)
                let networkCompanies = try self.networkService.getAllCompanies()
                completion(.success(networkCompanies))
                try self.coreDataManager.updateFromNetwork(companies: networkCompanies)
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getEmployees(from company: CompanyDTO, completion: @escaping (Result<[EmployeeDTO], Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let coreDataEmployees = try self.coreDataManager.getEmployees(from: company)
                completion(.success(coreDataEmployees))
                sleep(5)
                let networkEmployees = try self.networkService.getEmployees(from: company)
                completion(.success(networkEmployees))
                try self.coreDataManager.updateFromNetwork(from: company, employees: networkEmployees)
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func delete(company: CompanyDTO, completion: @escaping (Result<CompanyDTO?, Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let coreDataCompany = try self.coreDataManager.delete(company: company)
                completion(.success(coreDataCompany))
                sleep(5)
                let networkCompany = try self.networkService.delete(company: company)
                completion(.success(networkCompany))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func delete(employee: EmployeeDTO, from company: CompanyDTO, completion: @escaping (Result<EmployeeDTO?, Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let coreDataEmployee = try self.coreDataManager.delete(employee: employee, from: company)
                completion(.success(coreDataEmployee))
                sleep(5)
                let networkEmployee = try self.networkService.delete(employee: employee, from: company)
                completion(.success(networkEmployee))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func add(company: CompanyDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try self.coreDataManager.add(company: company)
                completion(.success(()))
                try self.networkService.add(company: company)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func add(employee: EmployeeDTO, to company: CompanyDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try self.coreDataManager.add(to: company, employee: employee)
                completion(.success(()))
                try self.networkService.add(to: company, employee: employee)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func update(employee: EmployeeDTO, from company: CompanyDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try self.coreDataManager.update(from: company, employee: employee)
                completion(.success(()))
                try self.networkService.update(from: company, employee: employee)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
}
