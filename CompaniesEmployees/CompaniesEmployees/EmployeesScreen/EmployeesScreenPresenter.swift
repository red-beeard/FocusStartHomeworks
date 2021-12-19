//
//  EmployeesScreenPresenter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

protocol IEmployeesScreenPresenter {
    func loadView(controller: IEmployeesScreenViewController, view: IEmployeesScreenView)
}

final class EmployeesScreenPresenter {
    
    private let dataManager: IDataManager
    private weak var controller: IEmployeesScreenViewController?
    private weak var view: IEmployeesScreenView?
    
    init(dataManager: IDataManager) {
        self.dataManager = dataManager
    }
    
}

extension EmployeesScreenPresenter: IEmployeesScreenPresenter {
    func loadView(controller: IEmployeesScreenViewController, view: IEmployeesScreenView) {
        self.controller = controller
        self.view = view
    }
}
