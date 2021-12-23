//
//  CompaniesScreenAssembly.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import UIKit

extension Notification.Name {
    static let companyUpdateNotification = Notification.Name("companyUpdateNotification")
}

final class CompaniesScreenAssembly {
    
    static func build() -> UIViewController {
        let dataManager = DataManager.shared
        let router = CompaniesScreenRouter()
        let tableAdapter = CompaniesScreenTableAdapter()
        
        let presenter = CompaniesScreenPresenter(dataManager: dataManager, tableAdapter: tableAdapter, router: router, center: NotificationCenter.default)
        let controller = TableScreenViewController(presenter: presenter)
        router.controller = controller
        
        return UINavigationController(rootViewController: controller)
    }
    
}
