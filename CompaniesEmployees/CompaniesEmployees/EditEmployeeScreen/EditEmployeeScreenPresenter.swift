//
//  EditEmployeeScreenPresenter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 21.12.2021.
//

import Foundation

protocol IEditEmployeeScreenPresenter {
    func loadView(controller: IEditEmployeeScreenViewController, view: IEditEmployeeScreenView)
}

final class EditEmployeeScreenPresenter {
    
    private let dataManager: IDataManager
    private let router: IEditEmployeeScreenRouter
    private let center: NotificationCenter
    private weak var controller: IEditEmployeeScreenViewController?
    private weak var view: IEditEmployeeScreenView?
    
    private let company: CompanyDTO
    private var employee: EmployeeDTO?
    
    init(company: CompanyDTO, employee: EmployeeDTO?, dataManager: IDataManager, router: IEditEmployeeScreenRouter, center: NotificationCenter) {
        self.company = company
        self.employee = employee
        self.dataManager = dataManager
        self.router = router
        self.center = center
    }
    
    private func setHandlers() {
        self.controller?.doneButtonHandler = { [weak self] in
            self?.saveEmployee()
        }
        
        self.controller?.cancelButtonHandler = { [weak self] in
            self?.router.goBack()
        }
        
        self.view?.checkTextFields = { [weak self] in
            if let viewModel = self?.view?.getViewModel() {
                let _ = self?.checkEmployee(viewModel: viewModel)
            }
        }
    }
    
    private func checkEmployee(viewModel: EditEmployeeViewModel) -> Bool {
        let checkName = self.checkEmployee(name: viewModel.name)
        if let error = checkName.error {
            self.view?.showErrorEmployeeName(error)
        } else {
            self.view?.hideErrorEmployeeName()
        }
        
        let checkAge = self.checkEmployee(age: viewModel.age)
        if let error = checkAge.error {
            self.view?.showErrorEmployeeAge(error)
        } else {
            self.view?.hideErrorEmployeeAge()
        }
        
        let checkExperience = self.checkEmployee(experience: viewModel.experience)
        if let error = checkExperience.error {
            self.view?.showErrorEmployeeExperience(error)
        } else {
            self.view?.hideErrorEmployeeExperience()
        }
        
        return checkName.check && checkAge.check && checkExperience.check
    }
    
    private func checkEmployee(name: String?) -> (check: Bool, error: String?) {
        guard let name = name, name.isEmpty == false else {
            return (false, "Введите имя")
        }
        return (true, nil)
    }
    
    private func checkEmployee(age: String?) -> (check: Bool, error: String?) {
        guard let age = age, age.isEmpty == false else {
            return (false, "Введите возраст")
        }
        
        if let _ = UInt(age) {
            return (true, nil)
        }
        
        return (false, "Некорректное значение")
    }
    
    private func checkEmployee(experience: String?) -> (check: Bool, error: String?) {
        guard let experience = experience, experience.isEmpty == false else {
            return (true, nil)
        }
        
        if let _ = UInt(experience) {
            return (true, nil)
        }
        
        return (false, "Некорректное значение")
    }
    
    private func saveEmployee() {
        guard let viewModel = self.view?.getViewModel(),
              self.checkEmployee(viewModel: viewModel) == true
        else {
            return
        }
        
        let newEmployee = EmployeeDTO(
            id: self.employee?.id,
            name: viewModel.name,
            age: viewModel.age,
            experience: viewModel.experience
        )
        guard let newEmployee = newEmployee else { return }
        
        if self.employee == nil {
            self.dataManager.add(employee: newEmployee, to: company, completion: completion)
        } else {
            self.dataManager.update(employee: newEmployee, from: company, completion: completion)
        }
    }
    
    private func completion(result: Result<Void, Error>) {
        switch result {
        case .success():
            DispatchQueue.main.async {
                self.center.post(name: Notification.Name.employeeUpdateNotification, object: nil)
                self.router.goBack()
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.controller?.showAlert(title: "Ошибка😔", message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
    
}

extension EditEmployeeScreenPresenter: IEditEmployeeScreenPresenter {
    
    func loadView(controller: IEditEmployeeScreenViewController, view: IEditEmployeeScreenView) {
        self.controller = controller
        self.view = view
        self.controller?.setTitle("Добавить сотрудника")
        
        if let employee = self.employee {
            self.view?.setViewModel(viewModel: EditEmployeeViewModel(employee: employee))
        }
        
        self.setHandlers()
    }
    
}
