//
//  CoreDataService.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import CoreData

protocol ICoreDataService: IDataService {
    func updateFromNetwork(companies: [CompanyDTO]) throws
    func updateFromNetwork(from company: CompanyDTO, employees: [EmployeeDTO]) throws
}

final class CoreDataService {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CompaniesModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func saveContext() {
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
    
    private func get(company: CompanyDTO) throws -> Company? {
        
        let fetchRequest = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", company.id.description)
        
        let companies = try persistentContainer.viewContext.fetch(fetchRequest)
        return companies.first
        
    }
}

extension CoreDataService: ICoreDataService {
    
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
        
        let savedCompanies = try self.getAllCompanies()
        if savedCompanies.contains(where: { $0.name == company.name}) == false {
            let newCompanyEntity = Company(entity: entity, insertInto: persistentContainer.viewContext)
            newCompanyEntity.setValues(from: company)
        }
        
        self.saveContext()
    }
    
    func add(to company: CompanyDTO, employee: EmployeeDTO) throws {
        let savedEmployees = try self.getEmployees(from: company)
        guard let entity = NSEntityDescription.entity(forEntityName: "Employee", in: persistentContainer.viewContext) else { return }
        
        if savedEmployees.contains(where: { $0.id == employee.id}) == false {
            let employeeEntity = Employee(entity: entity, insertInto: persistentContainer.viewContext)
            employeeEntity.setValues(from: employee)
        }
        
        self.saveContext()
    }
    
    func update(from company: CompanyDTO, employee: EmployeeDTO) throws {
        let fetchRequest = Employee.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "company.id = %@", company.id.description)
        
        let savedEmployees = try persistentContainer.viewContext.fetch(fetchRequest)
        
        if let index = savedEmployees.firstIndex(where: { $0.id == employee.id }) {
            savedEmployees[index].setValues(from: employee)
        }
        
        self.saveContext()
    }
    
    func updateFromNetwork(companies: [CompanyDTO]) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "Company", in: persistentContainer.viewContext) else { return }
        let fetchRequest = Company.fetchRequest()
        
        var newCompanies = companies
        let oldCompanies = try persistentContainer.viewContext.fetch(fetchRequest)
        
        for oldCompany in oldCompanies {
            if let index = newCompanies.firstIndex(where: { $0.id == oldCompany.id}) {
                oldCompany.setValues(from: newCompanies[index])
                newCompanies.remove(at: index)
            } else {
                persistentContainer.viewContext.delete(oldCompany)
            }
        }
        
        for newCompany in newCompanies {
            let newCompanyEntity = Company(entity: entity, insertInto: persistentContainer.viewContext)
            newCompanyEntity.setValues(from: newCompany)
        }
        
        self.saveContext()
    }
    
    func updateFromNetwork(from company: CompanyDTO, employees: [EmployeeDTO]) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "Employee", in: persistentContainer.viewContext) else { return }
        let fetchRequest = Employee.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "company.id = %@", company.id.description)
        
        var newEmployees = employees
        let oldEmployees = try persistentContainer.viewContext.fetch(fetchRequest)
        
        for oldEmployee in oldEmployees {
            if let index = newEmployees.firstIndex(where: { $0.id == oldEmployee.id}) {
                oldEmployee.setValues(from: newEmployees[index])
                newEmployees.remove(at: index)
            } else {
                persistentContainer.viewContext.delete(oldEmployee)
            }
        }
        
        if let companyEntity = try self.get(company: company) {
            for newEmployee in newEmployees {
                let newEmployeeEntity = Employee(entity: entity, insertInto: persistentContainer.viewContext)
                newEmployeeEntity.company = companyEntity
                newEmployeeEntity.setValues(from: newEmployee)
            }
        }
        
        self.saveContext()
    }
    
}

