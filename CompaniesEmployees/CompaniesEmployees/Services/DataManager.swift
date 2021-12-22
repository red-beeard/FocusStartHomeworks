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
    func add(companies: CompanyDTO...) throws
}

final class DataManager {
    
    static let shared = DataManager()
    
    private init() { }
    
    private let coreDataManager: IDataService = CoreDataManager()
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
                try self.coreDataManager.add(companies: company)
                completion(.success(()))
                try self.networkService.add(companies: company)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
}
