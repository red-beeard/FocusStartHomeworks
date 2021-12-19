//
//  CompanyViewController.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import UIKit

protocol ICompaniesViewController: UIViewController {
    func showAlert(title: String, message: String)
}

final class CompaniesViewController: UIViewController {
    
    private let presenter: ICompaniesScreenPresenter
    private let companyView: ICompaniesView = CompaniesView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: ICompaniesScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, view: self.companyView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.companyView
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Компании"
    }

}

extension CompaniesViewController: ICompaniesViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ок", style: .default) { action in
            self.dismiss(animated: true)
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
}

