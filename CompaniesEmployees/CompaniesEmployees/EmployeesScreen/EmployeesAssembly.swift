//
//  EmployeesAssembly.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

final class EmployeesAssembly {
    static func build(company: CompanyDTO) -> IEmployeesViewController {
        let dataManager = DataManager.shared
        let presenter = EmployeesPresenter(dataManager: dataManager)
        let controller = EmployeesViewController(presenter: presenter)
        
        return controller
    }
}
