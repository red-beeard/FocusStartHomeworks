//
//  TableScreenViewController.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 21.12.2021.
//

import UIKit

protocol ITableScreenViewController: UIViewController {
    func setTitle(_ title: String)
    func showAlert(title: String, message: String)
}

final class TableScreenViewController: UIViewController {
    
    private let presenter: ITableScreenPresenter
    private var tableScreenView: ITableScreenView = TableScreenView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: ITableScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, view: self.tableScreenView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = self.tableScreenView
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension TableScreenViewController: ITableScreenViewController {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ок", style: .default) { action in
            self.dismiss(animated: true)
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
}
