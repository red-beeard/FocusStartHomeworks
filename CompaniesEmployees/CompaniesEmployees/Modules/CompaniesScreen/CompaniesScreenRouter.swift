//
//  CompaniesScreenRouter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

import UIKit

protocol ICompaniesScreenRouter {
    func showEmployees(company: CompanyDTO)
}

final class CompaniesScreenRouter: ICompaniesScreenRouter {
    
    weak var controller: UIViewController?
    
    func showEmployees(company: CompanyDTO) {
        let employeesController = EmployeesScreenAssembly.build(company: company)
        self.controller?.navigationController?.pushViewController(employeesController, animated: true)
    }
    
}
