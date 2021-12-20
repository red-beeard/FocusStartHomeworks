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

final class DataManager {
    
    static let shared = DataManager()
    
    private init() { }
    
    private let coreDataManager: ICoreDataManager = CoreDataManager()
    private let networkService: INetworkService = NetworkService()
    
    private func getCompaniesFromCoreData(completion: @escaping (Result<[CompanyDTO], Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let companies = try self.coreDataManager.getAllCompanies()
                completion(.success(companies))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func getCompaniesFromNetwork(completion: @escaping (Result<[CompanyDTO], Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: DispatchTime.now() + 5) {
            do {
                let companies = try self.networkService.getAllCompanies()
                completion(.success(companies))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func getEmployeesFromCoreData(from company: CompanyDTO, completion: @escaping (Result<[EmployeeDTO], Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let companies = try self.coreDataManager.getEmployees(from: company)
                completion(.success(companies))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func getEmployeesFromNetwork(from company: CompanyDTO, completion: @escaping (Result<[EmployeeDTO], Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: DispatchTime.now() + 5) {
            do {
                let companies = try self.networkService.getEmployees(from: company)
                completion(.success(companies))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
}

extension DataManager: IDataManager {
    
    func getCompanies(completion: @escaping (Result<[CompanyDTO], Error>) -> Void) {
        self.getCompaniesFromCoreData(completion: completion)
        self.getCompaniesFromNetwork(completion: completion)
    }
    
    func getEmployees(from company: CompanyDTO, completion: @escaping (Result<[EmployeeDTO], Error>) -> Void) {
        self.getEmployeesFromCoreData(from: company, completion: completion)
        self.getEmployeesFromNetwork(from: company, completion: completion)
    }
    
}
