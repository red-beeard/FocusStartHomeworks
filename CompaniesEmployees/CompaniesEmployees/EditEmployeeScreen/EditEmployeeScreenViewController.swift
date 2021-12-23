//
//  AddCompanyScreenViewController.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 21.12.2021.
//

import UIKit

protocol IEditEmployeeScreenViewController: UIViewController {
    var cancelButtonHandler: (() -> Void)? { get set }
    var doneButtonHandler: (() -> Void)? { get set }
    func setTitle(_ title: String)
    func showAlert(title: String, message: String)
}

final class EditEmployeeScreenViewController: UIViewController {
    
    private let presenter: IEditEmployeeScreenPresenter
    private let addCompanyView: IEditEmployeeScreenView
    
    var cancelButtonHandler: (() -> Void)?
    var doneButtonHandler: (() -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: IEditEmployeeScreenPresenter) {
        self.presenter = presenter
        self.addCompanyView = EditEmployeeScreenView()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, view: self.addCompanyView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuireView()
    }
    
    private func configuireView() {
        self.view = self.addCompanyView
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
    }
    
    @objc private func doneButtonTapped() {
        self.doneButtonHandler?()
    }
    
    @objc private func cancelButtonTapped() {
        self.cancelButtonHandler?()
    }
    
}

extension EditEmployeeScreenViewController: IEditEmployeeScreenViewController {
    
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
