//
//  SelectCurrencyScreenAssembly.swift
//  CurrencyConverter
//
//  Created by Red Beard on 23.12.2021.
//

import UIKit

final class SelectCurrencyScreenAssembly {
    static func build(for key: String) -> UIViewController {
        let dataManager = DataManager.shared
        let router = SelectCurrencyScreenRouter()
        let tableAdapter = SelectCurrencyScreenTableAdapter()
        
        let presenter = SelectCurrencyScreenPresenter(
            keyForSelect: key,
            dataManager: dataManager,
            router: router,
            tableAdapter: tableAdapter
        )
        
        let controller = SelectCurrencyScreenViewController(presenter: presenter)
        router.controller = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
