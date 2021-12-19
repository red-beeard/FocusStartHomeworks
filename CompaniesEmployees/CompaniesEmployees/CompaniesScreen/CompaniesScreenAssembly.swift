//
//  CompaniesScreenAssembly.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import UIKit

final class CompaniesScreenAssembly {
    
    static func build() -> UIViewController {
        let dataManager = DataManager.shared
        let tableAdapter = CompaniesScreenTableAdapter()
        let presenter = CompaniesScreenPresenter(dataManager: dataManager, tableAdapter: tableAdapter)
        let controller = CompaniesScreenViewController(presenter: presenter)
        
        return UINavigationController(rootViewController: controller)
    }
    
}
