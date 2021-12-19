//
//  CompanyScreenPresenter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import Foundation

protocol ICompanyListScreenPresenter {
    func loadView(controller: ICompanyListViewController, view: ICompanyListView)
}

final class CompanyListScreenPresenter {
    
    private let dataManager: IDataManager
    private let tableAdapter: ICompanyListTableAdapter
    private weak var controller: ICompanyListViewController?
    private weak var view: ICompanyListView?
    
    private var companies = [CompanyDTO]()
    
    init(dataManager: IDataManager, tableAdapter: ICompanyListTableAdapter) {
        self.dataManager = dataManager
        self.tableAdapter = tableAdapter
    }
    
    private func loadData() {
        self.dataManager.getCompanies { result in
            switch result {
            case .success(let companies):
                DispatchQueue.main.async {
                    self.companies = companies
                    let companiesViewModel = companies.map { CompanyListViewModel(company: $0) }
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

extension CompanyListScreenPresenter: ICompanyListScreenPresenter {
    
    func loadView(controller: ICompanyListViewController, view: ICompanyListView) {
        self.controller = controller
        self.view = view
        self.tableAdapter.tableView = self.view?.getTableView()
        
        self.loadData()
    }
    
}
