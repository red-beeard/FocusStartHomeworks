//
//  AddCompanyScreenRouter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 21.12.2021.
//

import UIKit

protocol IAddCompanyScreenRouter {
    func goBack()
}

final class AddCompanyScreenRouter {
    
    var controller: UIViewController?
    
}

extension AddCompanyScreenRouter: IAddCompanyScreenRouter {
    
    func goBack() {
        self.controller?.dismiss(animated: true)
    }
    
}
