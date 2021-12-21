//
//  EmployeesScreenAssembly.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

import UIKit

final class EmployeesScreenAssembly {
    static func build(company: CompanyDTO) -> UIViewController {
        let dataManager = DataManager.shared
        let tableAdapter = EmployeesScreenTableAdapter()
        let router = EmployeesScreenRouter()
        
        let presenter = EmployeesScreenPresenter(
            company: company,
            dataManager: dataManager,
            tableAdapter: tableAdapter,
            router: router
        )
        let controller = TableScreenViewController(presenter: presenter)
        
        return controller
    }
}
