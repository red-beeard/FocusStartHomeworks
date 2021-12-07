//
//  SelectBodyRouter.swift
//  CarAppMobile
//
//  Created by Red Beard on 07.12.2021.
//

import UIKit

protocol ISelectBodyRouter {
    var controller: UIViewController? { get set }
    
    func setRootController(controller: UIViewController)
    func prev()
}

final class SelectBodyRouter: ISelectBodyRouter {
    
    var controller: UIViewController?
    
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    
    func prev() {
        self.controller?.navigationController?.popToRootViewController(animated: true)
    }
    
}
