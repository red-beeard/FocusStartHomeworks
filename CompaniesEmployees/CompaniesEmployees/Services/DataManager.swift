//
//  DataManager.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import Foundation

protocol IDataManager {
    func getCompanies(completion: @escaping (Result<[CompanyDTO], Error>) -> Void)
}

final class DataManager {
    
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
    
}

extension DataManager: IDataManager {
    
    func getCompanies(completion: @escaping (Result<[CompanyDTO], Error>) -> Void) {
        self.getCompaniesFromCoreData(completion: completion)
        self.getCompaniesFromNetwork(completion: completion)
    }
    
}
