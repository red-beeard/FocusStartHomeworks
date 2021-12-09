//
//  SelectBrandAssembly.swift
//  CarAppMobile
//
//  Created by Red Beard on 03.12.2021.
//

import UIKit

final class SelectBrandAssembly {
    
    static func build() -> ISelectBrandViewController {
        let model = CarModel.shared
        let router = SelectBrandRouter()
        let presenter = SelectBrandPresenter(model: model, router: router)
        
        let controller = SelectBrandViewController(presenter: presenter)
        let targetController = SelectBodyAssembly.build()
        
        router.setRootController(controller: controller)
        router.setTargetController(controller: targetController)
        
        return controller
    }
    
}
