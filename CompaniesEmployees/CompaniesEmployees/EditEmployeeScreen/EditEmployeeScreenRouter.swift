//
//  AddCompanyScreenRouter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 21.12.2021.
//

import UIKit

protocol IEditEmployeeScreenRouter {
    func goBack()
}

final class EditEmployeeScreenRouter {
    
    var controller: UIViewController?
    
}

extension EditEmployeeScreenRouter: IEditEmployeeScreenRouter {
    
    func goBack() {
        self.controller?.dismiss(animated: true)
    }
    
}
