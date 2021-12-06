//
//  SelectBrandAssembly.swift
//  CarAppMobile
//
//  Created by Red Beard on 03.12.2021.
//

import UIKit

final class SelectBrandAssembly {
    
    static func build() -> UIViewController {
        let model = CarModel.shared
        let presenter = SelectBrandPresenter(model: model)
        let controller = SelectBrandViewController(presenter: presenter)
        return controller
    }
    
}
