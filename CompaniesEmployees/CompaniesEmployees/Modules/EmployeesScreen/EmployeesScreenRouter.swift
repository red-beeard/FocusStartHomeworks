//
//  EmployeesScreenRouter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

import UIKit

protocol IEmployeesScreenRouter {
    func editEmployee(company: CompanyDTO, employee: EmployeeDTO?)
}

final class EmployeesScreenRouter: IEmployeesScreenRouter {
    
    weak var controller: UIViewController?
        
    func editEmployee(company: CompanyDTO, employee: EmployeeDTO? = nil) {
        let editEmployeeController = EditEmployeeScreenAssembly.build(company: company, employee: employee)
        self.controller?.present(editEmployeeController, animated: true)
    }
}
