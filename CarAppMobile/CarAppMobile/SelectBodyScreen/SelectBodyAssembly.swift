//
//  SelectBodyAssembly.swift
//  CarAppMobile
//
//  Created by Red Beard on 07.12.2021.
//

import UIKit

final class SelectBodyAssembly {
    
    static func build() -> ISelectBodyViewController {
        let model = CarModel.shared
        let router = SelectBodyRouter()
        let presenter = SelectBodyPresenter(model: model, router: router)
        
        let controller = SelectBodyViewController(presenter: presenter)
        
        router.setRootController(controller: controller)
        
        return controller
    }
    
}
