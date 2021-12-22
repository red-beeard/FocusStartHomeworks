//
//  CompaniesScreenPresenter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import Foundation

final class CompaniesScreenPresenter {
    
    private enum Constants {
        static let viewTitle = "Компании"
    }
    
    private let dataManager: IDataManager
    private let tableAdapter: ICompaniesScreenTableAdapter
    private let router: ICompaniesScreenRouter
    private let center: NotificationCenter
    private weak var controller: ITableScreenViewController?
    private weak var view: ITableScreenView?
    
    private var companies = [CompanyDTO]()
    
    init(dataManager: IDataManager, tableAdapter: ICompaniesScreenTableAdapter, router: ICompaniesScreenRouter, center: NotificationCenter) {
        self.dataManager = dataManager
        self.tableAdapter = tableAdapter
        self.router = router
        self.center = center
        self.center.addObserver(self, selector: #selector(reloadCompanies),
                                name: Notification.Name.companyUpdateNotification,
                                object: nil)
    }

    deinit {
        self.center.removeObserver(self)
    }
    
    private func loadData() {
        self.dataManager.getCompanies { result in
            switch result {
            case .success(let companies):
                DispatchQueue.main.async {
                    self.companies = companies
                    let companiesViewModel = companies.map { CompaniesScreenViewModel(company: $0) }
                    self.tableAdapter.update(companies: companiesViewModel)
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
            self?.router.addCompany()
        }
    }
    
    @objc func reloadCompanies() {
        self.loadData()
    }
    
}

extension CompaniesScreenPresenter: ITableScreenPresenter {
    
    func loadView(controller: ITableScreenViewController, view: ITableScreenView) {
        self.controller = controller
        self.view = view
        self.controller?.setTitle(Constants.viewTitle)
        self.tableAdapter.tableView = self.view?.getTableView()
        self.tableAdapter.delegate = self
        
        self.loadData()
        self.setHandlers()
    }
    
}

extension CompaniesScreenPresenter: CompaniesScreenTableAdapterDelegate {
    
    func onItemSelect(id: UUID) {
        guard let company = self.companies.first(where: { id == $0.id }) else { return }
        self.router.showEmployees(company: company)
    }
    
    func onItemDelete(id: UUID) {
        guard let company = self.companies.first(where: { id == $0.id }) else { return }
        self.dataManager.delete(company: company) { result in
            switch result {
            case .success(let company):
                DispatchQueue.main.async {
                    if let company = company {
                        self.companies.removeAll { $0.id == company.id }
                        self.tableAdapter.deleteRow(at: company.id)
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
