//
//  EmployeesScreenPresenter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

import Foundation

final class EmployeesScreenPresenter {
    
    private let dataManager: IDataManager
    private let router: IEmployeesScreenRouter
    private var tableAdapter: IEmployeesScreenTableAdapter
    private weak var controller: ITableScreenViewController?
    private weak var view: ITableScreenView?
    
    private let company: CompanyDTO
    private var employees = [EmployeeDTO]()
    
    init(company: CompanyDTO, dataManager: IDataManager, tableAdapter: IEmployeesScreenTableAdapter, router: IEmployeesScreenRouter) {
        self.company = company
        self.dataManager = dataManager
        self.tableAdapter = tableAdapter
        self.router = router
    }
    
    private func loadData() {
        self.dataManager.getEmployees(from: self.company) { result in
            switch result {
            case .success(let employees):
                DispatchQueue.main.async {
                    self.employees = employees
                    let employeesViewModel = employees.map { EmployeesScreenViewModel(employee: $0) }
                    self.tableAdapter.update(employees: employeesViewModel)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.controller?.showAlert(title: "Ошибка😔", message: error.localizedDescription)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

extension EmployeesScreenPresenter: ITableScreenPresenter {
    func loadView(controller: ITableScreenViewController, view: ITableScreenView) {
        self.controller = controller
        self.controller?.setTitle(company.name)
        self.view = view
        self.tableAdapter.tableView = self.view?.getTableView()
        
        self.loadData()
    }
}
