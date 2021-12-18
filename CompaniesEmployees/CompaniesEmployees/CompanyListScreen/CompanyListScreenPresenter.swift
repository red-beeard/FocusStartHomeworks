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
    private var controller: ICompanyListViewController?
    private var view: ICompanyListView?
    
    private var companies: [CompanyDTO]?
    
    init(dataManager: IDataManager) {
        self.dataManager = dataManager
    }
    
    private func loadData() {
        dataManager.getCompanies { result in
            switch result {
            case .success(let companies):
                DispatchQueue.main.async {
                    print("Количество \(companies.count)")
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
        
        self.loadData()
    }
    
}
