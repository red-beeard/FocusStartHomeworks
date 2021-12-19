//
//  CompanyScreenAssembly.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import UIKit

final class CompanyListScreenAssembly {
    
    static func build() -> UIViewController {
        let dataManager = DataManager()
        let tableAdapter = CompanyListTableAdapter()
        let presenter = CompanyListScreenPresenter(dataManager: dataManager, tableAdapter: tableAdapter)
        let controller = CompanyListViewController(presenter: presenter)
        
        return UINavigationController(rootViewController: controller)
    }
    
}
