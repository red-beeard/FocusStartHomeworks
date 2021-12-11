//
//  SelectBodyRouter.swift
//  CarAppMobile
//
//  Created by Red Beard on 11.12.2021.
//

protocol ISelectBodyRouter {
    var controller: ISelectBodyViewController? { get set }
    
    func setRootController(controller: ISelectBodyViewController)
    func toRootVC()
}

final class SelectBodyRouter: ISelectBodyRouter {
    
    weak var controller: ISelectBodyViewController?
    
    func setRootController(controller: ISelectBodyViewController) {
        self.controller = controller
    }
    
    func toRootVC() {
        self.controller?.navigationController?.popToRootViewController(animated: true)
    }
    
}
