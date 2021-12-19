//
//  CompaniesScreenPresenter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import Foundation

protocol ICompaniesScreenPresenter {
    func loadView(controller: ICompaniesScreenViewController, view: ICompaniesScreenView)
}

final class CompaniesScreenPresenter {
    
    private let dataManager: IDataManager
    private let tableAdapter: ICompaniesScreenTableAdapter
    private weak var controller: ICompaniesScreenViewController?
    private weak var view: ICompaniesScreenView?
    
    private var companies = [CompanyDTO]()
    
    init(dataManager: IDataManager, tableAdapter: ICompaniesScreenTableAdapter) {
        self.dataManager = dataManager
        self.tableAdapter = tableAdapter
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
    
}

extension CompaniesScreenPresenter: ICompaniesScreenPresenter {
    
    func loadView(controller: ICompaniesScreenViewController, view: ICompaniesScreenView) {
        self.controller = controller
        self.view = view
        self.tableAdapter.tableView = self.view?.getTableView()
        self.tableAdapter.delegate = self
        
        self.loadData()
    }
    
}

extension CompaniesScreenPresenter: CompaniesScreenTableAdapterDelegate {
    
    func onItemSelect(id: UUID) {
        guard let company = self.companies.first(where: { id == $0.id })  else { return }
        let nextController = EmployeesScreenAssembly.build(company: company)
        self.controller?.navigationController?.pushViewController(nextController, animated: true)
    }
    
}
