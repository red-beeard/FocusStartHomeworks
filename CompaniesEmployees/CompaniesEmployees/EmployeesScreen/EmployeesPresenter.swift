//
//  EmployeesPresenter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

protocol IEmployeesPresenter {
    func loadView(controller: IEmployeesViewController, view: IEmployeesView)
}

final class EmployeesPresenter {
    
    private let dataManager: IDataManager
    private weak var controller: IEmployeesViewController?
    private weak var view: IEmployeesView?
    
    init(dataManager: IDataManager) {
        self.dataManager = dataManager
    }
    
}

extension EmployeesPresenter: IEmployeesPresenter {
    func loadView(controller: IEmployeesViewController, view: IEmployeesView) {
        self.controller = controller
        self.view = view
    }
}
