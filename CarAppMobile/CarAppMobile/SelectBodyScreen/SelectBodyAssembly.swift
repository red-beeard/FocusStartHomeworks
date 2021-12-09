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
        let presenter = SelectBodyPresenter(model: model)
        
        let controller = SelectBodyViewController(presenter: presenter)
        
        return controller
    }
    
}
