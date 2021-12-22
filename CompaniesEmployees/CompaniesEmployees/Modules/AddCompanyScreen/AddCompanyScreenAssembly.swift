//
//  AddCompanyScreenAssembly.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 21.12.2021.
//

import UIKit

final class AddCompanyScreenAssembly {
    static func build() -> UIViewController {
        let dataManager = DataManager.shared
        let router = AddCompanyScreenRouter()
        let presenter = AddCompanyScreenPresenter(dataManager: dataManager, router: router, center: NotificationCenter.default)
        
        let controller = AddCompanyScreenViewController(presenter: presenter)
        router.controller = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
