//
//  SelectBrandRouter.swift
//  CarAppMobile
//
//  Created by Red Beard on 06.12.2021.
//

import UIKit

protocol ISelectBrandRouter {
    var controller: ISelectBrandViewController? { get set }
    var targetController: ISelectBodyViewController? { get set }
    
    func setRootController(controller: ISelectBrandViewController)
    func setTargetController(controller: ISelectBodyViewController)
    func next(index: Int)
}

final class SelectBrandRouter: ISelectBrandRouter {
    
    var controller: ISelectBrandViewController?
    var targetController: ISelectBodyViewController?
    
    func setRootController(controller: ISelectBrandViewController) {
        self.controller = controller
    }
    
    func setTargetController(controller: ISelectBodyViewController) {
        self.targetController = controller
    }
    
    func next(index: Int) {
        guard let targetController = self.targetController else {
            return
        }
        
        self.targetController?.setCarBrand(index: index)
        self.controller?.navigationController?.pushViewController(targetController, animated: true)
    }
    
}
