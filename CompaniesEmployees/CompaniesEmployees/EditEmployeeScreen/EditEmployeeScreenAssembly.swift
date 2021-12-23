//
//  EditEmployeeScreenAssembly.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 21.12.2021.
//

import UIKit

final class EditEmployeeScreenAssembly {
    static func build(company: CompanyDTO, employee: EmployeeDTO? = nil) -> UIViewController {
        let dataManager = DataManager.shared
        let router = EditEmployeeScreenRouter()
        let presenter = EditEmployeeScreenPresenter(
            company: company,
            employee: employee,
            dataManager: dataManager,
            router: router,
            center: NotificationCenter.default
        )
        
        let controller = EditEmployeeScreenViewController(presenter: presenter)
        router.controller = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
