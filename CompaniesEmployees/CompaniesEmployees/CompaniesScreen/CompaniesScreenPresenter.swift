//
//  CompanyScreenPresenter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import Foundation

protocol ICompaniesScreenPresenter {
    func loadView(controller: ICompaniesViewController, view: ICompaniesView)
}

final class CompaniesScreenPresenter {
    
    private let dataManager: IDataManager
    private let tableAdapter: ICompaniesTableAdapter
    private weak var controller: ICompaniesViewController?
    private weak var view: ICompaniesView?
    
    private var companies = [CompanyDTO]()
    
    init(dataManager: IDataManager, tableAdapter: ICompaniesTableAdapter) {
        self.dataManager = dataManager
        self.tableAdapter = tableAdapter
    }
    
    private func loadData() {
        self.dataManager.getCompanies { result in
            switch result {
            case .success(let companies):
                DispatchQueue.main.async {
                    self.companies = companies
                    let companiesViewModel = companies.map { CompaniesViewModel(company: $0) }
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
    
}

extension CompaniesScreenPresenter: ICompaniesScreenPresenter {
    
    func loadView(controller: ICompaniesViewController, view: ICompaniesView) {
        self.controller = controller
        self.view = view
        self.tableAdapter.tableView = self.view?.getTableView()
        self.tableAdapter.delegate = self
        
        self.loadData()
    }
    
}

extension CompaniesScreenPresenter: CompaniesTableAdapterDelegate {
    
    func onItemSelect(id: UUID) {
        guard let company = self.companies.first(where: { id == $0.id })  else { return }
        let nextController = EmployeesAssembly.build(company: company)
        self.controller?.navigationController?.pushViewController(nextController, animated: true)
    }
    
}
