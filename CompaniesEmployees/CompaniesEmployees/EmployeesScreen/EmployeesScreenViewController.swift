//
//  EmployeesScreenViewController.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

import UIKit

protocol IEmployeesScreenViewController: UIViewController {
    
}

final class EmployeesScreenViewController: UIViewController {
    
    private let presenter: IEmployeesScreenPresenter
    private var employeesView: IEmployeesScreenView = EmployeesScreenView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: IEmployeesScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, view: self.employeesView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = self.employeesView
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension EmployeesScreenViewController: IEmployeesScreenViewController {
    
}
