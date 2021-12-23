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
    private let center: NotificationCenter
    private var tableAdapter: IEmployeesScreenTableAdapter
    private weak var controller: ITableScreenViewController?
    private weak var view: ITableScreenView?
    
    private let company: CompanyDTO
    private var employees = [EmployeeDTO]()
    
    init(company: CompanyDTO, dataManager: IDataManager, tableAdapter: IEmployeesScreenTableAdapter, router: IEmployeesScreenRouter, center: NotificationCenter) {
        self.company = company
        self.dataManager = dataManager
        self.tableAdapter = tableAdapter
        self.router = router
        self.center = center
        self.center.addObserver(self, selector: #selector(reloadEmployees),
                                name: Notification.Name.employeeUpdateNotification,
                                object: nil)
    }
    
    deinit {
        self.center.removeObserver(self)
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
    
    private func setHandlers() {
        self.controller?.addButtonHandler = { [weak self] in
            if let company = self?.company {
                self?.router.editEmployee(company: company, employee: nil)
            }
        }
    }
    
    @objc func reloadEmployees() {
        self.loadData()
    }
    
}

extension EmployeesScreenPresenter: ITableScreenPresenter {
    func loadView(controller: ITableScreenViewController, view: ITableScreenView) {
        self.controller = controller
        self.controller?.setTitle(company.name)
        self.view = view
        self.tableAdapter.tableView = self.view?.getTableView()
        self.tableAdapter.delegate = self
        
        self.loadData()
        self.setHandlers()
    }
}

extension EmployeesScreenPresenter: EmployeesScreenTableAdapterDelegate {
    
    func onItemSelect(id: UUID) {
        if let employee = self.employees.first(where: { $0.id == id }) {
            self.router.editEmployee(company: self.company, employee: employee)
        }
    }
    
    func onItemDelete(id: UUID) {
        guard let employee = self.employees.first(where: { id == $0.id }) else { return }
        self.dataManager.delete(employee: employee, from: self.company) { result in
            switch result {
            case .success(let employee):
                DispatchQueue.main.async {
                    if let employee = employee {
                        self.employees.removeAll { $0.id == employee.id }
                        self.tableAdapter.deleteRow(at: employee.id)
                    }
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
