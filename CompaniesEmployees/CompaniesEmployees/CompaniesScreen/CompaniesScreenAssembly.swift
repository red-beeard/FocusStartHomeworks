//
//  CompanyScreenAssembly.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import UIKit

final class CompaniesScreenAssembly {
    
    static func build() -> UIViewController {
        let dataManager = DataManager()
        let tableAdapter = CompaniesTableAdapter()
        let presenter = CompaniesScreenPresenter(dataManager: dataManager, tableAdapter: tableAdapter)
        let controller = CompaniesViewController(presenter: presenter)
        
        return UINavigationController(rootViewController: controller)
    }
    
}
