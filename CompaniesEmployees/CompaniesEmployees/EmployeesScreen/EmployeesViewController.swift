//
//  EmployeesViewController.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

import UIKit

protocol IEmployeesViewController: UIViewController {
    
}

final class EmployeesViewController: UIViewController {
    
    private let presenter: IEmployeesPresenter
    private var employeesView: IEmployeesView = EmployeesView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: IEmployeesPresenter) {
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

extension EmployeesViewController: IEmployeesViewController {
    
}
