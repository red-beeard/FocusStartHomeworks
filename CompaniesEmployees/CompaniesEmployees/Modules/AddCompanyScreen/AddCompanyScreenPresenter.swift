//
//  AddCompanyScreenPresenter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 21.12.2021.
//

import Foundation

protocol IAddCompanyScreenPresenter {
    func loadView(controller: IAddCompanyScreenViewController, view: IAddCompanyScreenView)
}

final class AddCompanyScreenPresenter {
    
    private let dataManager: IDataManager
    private let router: IAddCompanyScreenRouter
    private let center: NotificationCenter
    private weak var controller: IAddCompanyScreenViewController?
    private weak var view: IAddCompanyScreenView?
    
    init(dataManager: IDataManager, router: IAddCompanyScreenRouter, center: NotificationCenter) {
        self.dataManager = dataManager
        self.router = router
        self.center = center
    }
    
    private func setHandlers() {
        self.controller?.doneButtonHandler = { [weak self] in
            if self?.checkCompanyName().check == true,
               let name = self?.view?.getCompanyName(){
                let company = CompanyDTO(name: name)
                self?.dataManager.add(company: company) { result in
                    switch result {
                    case .success():
                        DispatchQueue.main.async {
                            self?.center.post(name: Notification.Name.companyUpdateNotification, object: nil)
                            self?.router.goBack()
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.controller?.showAlert(title: "Ошибка😔", message: error.localizedDescription)
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
        
        self.controller?.cancelButtonHandler = { [weak self] in
            self?.router.goBack()
        }
        
        self.view?.checkCompanyName = { [weak self] in
            let result = self?.checkCompanyName()
            if let error = result?.error {
                self?.view?.showErrorCompanyName(error)
            } else {
                self?.view?.hideErrorCompanyName()
            }
        }
        
    }
    
    private func checkCompanyName() -> (check: Bool, error: String?) {
        let name = self.view?.getCompanyName()
        
        guard let name = name, name.isEmpty == false  else {
            return (false, "Введите название")
        }
        return (true, nil)
    }
    
}

extension AddCompanyScreenPresenter: IAddCompanyScreenPresenter {
    
    func loadView(controller: IAddCompanyScreenViewController, view: IAddCompanyScreenView) {
        self.controller = controller
        self.view = view
        self.controller?.setTitle("Добавить компанию")
        
        self.setHandlers()
    }
    
}
