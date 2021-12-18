//
//  CoreDataManager.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import CoreData

protocol ICoreDataManager {
    
    func getAllCompanies() throws -> [CompanyDTO]
    func addCompanies(_ companies: [CompanyDTO]) throws
    
}

final class CoreDataManager {
    
//    static let shared = CoreDataManager()
//
//    private init() {
//
//    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CompaniesModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataManager: ICoreDataManager {
    
    func getAllCompanies() throws -> [CompanyDTO] {
        let fetchRequest = Company.fetchRequest()
        let companies = try persistentContainer.viewContext.fetch(fetchRequest)
        
        let result = companies.compactMap { company -> CompanyDTO? in
            guard let name = company.name else { return nil }
            guard let id = company.id else { return nil }
            return CompanyDTO(id: id, name: name)
        }
        
        return result
    }
    
    func addCompanies(_ companies: [CompanyDTO]) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "Company", in: persistentContainer.viewContext) else { return }
        
        for companyDTO in companies {
            let company = Company(entity: entity, insertInto: persistentContainer.viewContext)
            company.name = companyDTO.name
        }
        
        try persistentContainer.viewContext.save()
    }
    
}

