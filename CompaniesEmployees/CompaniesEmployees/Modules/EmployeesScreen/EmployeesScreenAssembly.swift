//
//  EmployeesScreenAssembly.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

import UIKit

extension Notification.Name {
    static let employeeUpdateNotification = Notification.Name("employeeUpdateNotification")
}

final class EmployeesScreenAssembly {
    static func build(company: CompanyDTO) -> UIViewController {
        let dataManager = DataManager.shared
        let tableAdapter = EmployeesScreenTableAdapter()
        let router = EmployeesScreenRouter()
        
        let presenter = EmployeesScreenPresenter(
            company: company,
            dataManager: dataManager,
            tableAdapter: tableAdapter,
            router: router,
            center: NotificationCenter.default
        )
        let controller = TableScreenViewController(presenter: presenter)
        router.controller = controller
        
        return controller
    }
}
