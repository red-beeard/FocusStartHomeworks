//
//  SelectBrandRouter.swift
//  CarAppMobile
//
//  Created by Red Beard on 06.12.2021.
//

protocol ISelectBrandRouter {
    var controller: ISelectBrandViewController? { get set }
    
    func setRootController(controller: ISelectBrandViewController)
    func next(index: Int)
}

final class SelectBrandRouter: ISelectBrandRouter {
    
    var controller: ISelectBrandViewController?
    
    func setRootController(controller: ISelectBrandViewController) {
        self.controller = controller
    }
    
    func next(index: Int) {
        let targetController = SelectBodyAssembly.build()
        targetController.setCarBrand(index: index)
        self.controller?.navigationController?.pushViewController(targetController, animated: true)
    }
    
}
