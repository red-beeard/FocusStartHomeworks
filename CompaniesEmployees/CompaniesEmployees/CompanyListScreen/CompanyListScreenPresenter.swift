//
//  CompanyScreenPresenter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

protocol ICompanyListScreenPresenter {
    func loadView(controller: ICompanyListViewController, view: ICompanyListView)
}

final class CompanyListScreenPresenter {
    
    private let dataManager: IDataManager
    private var controller: ICompanyListViewController?
    private var view: ICompanyListView?
    
    init(dataManager: IDataManager) {
        self.dataManager = dataManager
    }
    
}

extension CompanyListScreenPresenter: ICompanyListScreenPresenter {
    
    func loadView(controller: ICompanyListViewController, view: ICompanyListView) {
        self.controller = controller
        self.view = view
    }
    
}
