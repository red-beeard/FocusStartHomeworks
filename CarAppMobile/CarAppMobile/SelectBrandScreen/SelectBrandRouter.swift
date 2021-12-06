//
//  SelectBrandRouter.swift
//  CarAppMobile
//
//  Created by Red Beard on 06.12.2021.
//

import UIKit

protocol ISelectBrandRouter {
    var controller: UIViewController? { get set }
    var targetController: UIViewController? { get set }
    
    func setRootController(controller: UIViewController)
    func setTargetController(controller: UIViewController)
    func next(index: Int)
}

final class SelectBrandRouter: ISelectBrandRouter {
    
    var controller: UIViewController?
    var targetController: UIViewController?
    
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    
    func setTargetController(controller: UIViewController) {
        self.targetController = controller
    }
    
    func next(index: Int) {
        print(index)
        print(#function)
    }
    
}
