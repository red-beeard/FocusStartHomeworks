//
//  EmployeesScreenAssembly.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

final class EmployeesScreenAssembly {
    static func build(company: CompanyDTO) -> IEmployeesScreenViewController {
        let dataManager = DataManager.shared
        let tableAdapter = EmployeesScreenTableAdapter()
        let router = EmployeesScreenRouter()
        
        let presenter = EmployeesScreenPresenter(
            company: company,
            dataManager: dataManager,
            tableAdapter: tableAdapter,
            router: router
        )
        let controller = EmployeesScreenViewController(presenter: presenter)
        
        return controller
    }
}
