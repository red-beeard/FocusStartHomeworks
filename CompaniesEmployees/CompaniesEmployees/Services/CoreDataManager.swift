//
//  CoreDataManager.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import CoreData

final class CoreDataManager {

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

extension CoreDataManager: IDataService {
    
    func getAllCompanies() throws -> [CompanyDTO] {
        let fetchRequest = Company.fetchRequest()
        let companies = try persistentContainer.viewContext.fetch(fetchRequest)
        
        return companies.compactMap { CompanyDTO(company: $0) }
    }
    
    func getEmployees(from company: CompanyDTO) throws -> [EmployeeDTO] {
        let fetchRequest = Employee.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "company.id = %@", company.id.description)
        
        let employees = try persistentContainer.viewContext.fetch(fetchRequest)
        return employees.compactMap { EmployeeDTO(employee: $0) }
    }
    
    func delete(company: CompanyDTO) throws -> CompanyDTO? {
        let fetchRequest = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", company.id.description)
        
        let companies = try persistentContainer.viewContext.fetch(fetchRequest)
        if let companyForDelete = companies.first {
            persistentContainer.viewContext.delete(companyForDelete)
            self.saveContext()
            return company
        }
        return nil
    }
    
    func delete(employee: EmployeeDTO, from company: CompanyDTO) throws -> EmployeeDTO? {
        let fetchRequest = Employee.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", employee.id.description)
        
        let employees = try persistentContainer.viewContext.fetch(fetchRequest)
        if let employeeForDelete = employees.first {
            persistentContainer.viewContext.delete(employeeForDelete)
            self.saveContext()
            return employee
        }
        return nil
    }
    
    func add(company: CompanyDTO) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "Company", in: persistentContainer.viewContext) else { return }
        
        let newCompany = Company(entity: entity, insertInto: persistentContainer.viewContext)
        newCompany.setValues(from: company)
        
        self.saveContext()
    }
    
}

