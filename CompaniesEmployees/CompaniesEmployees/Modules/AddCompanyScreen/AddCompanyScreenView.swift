//
//  AddCompanyScreenView.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 21.12.2021.
//

import UIKit

protocol IAddCompanyScreenView: UIView {
    var checkCompanyName: (() -> Void)? { get set }
    func getCompanyName() -> String?
    func showErrorCompanyName(_ text: String)
    func hideErrorCompanyName()
}

final class AddCompanyScreenView: UIView {
    
    private enum Constants {
        static let spacing = CGFloat(20)
    }
    
    private let companyName = TextFieldWithError()
    
    var checkCompanyName: (() -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuireView()
        self.configuireViewLayout()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.checkCompanyName?()
    }
    
}

//MARK: Configuire view
extension AddCompanyScreenView {
    
    private func configuireView() {
        self.backgroundColor = .systemBackground
        
        self.companyName.translatesAutoresizingMaskIntoConstraints = false
        self.companyName.titleLabel.text = "Название компании"
        self.companyName.textField.placeholder = "Название компании"
        self.companyName.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
}

//MARK: Configuire view
extension AddCompanyScreenView {
    
    private func configuireViewLayout() {
        self.addSubview(companyName)
        
        NSLayoutConstraint.activate([
            self.companyName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.spacing),
            self.companyName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.spacing),
            self.companyName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.spacing),
        ])
    }
    
}

extension AddCompanyScreenView: IAddCompanyScreenView {
    
    func getCompanyName() -> String? {
        return self.companyName.textField.text
    }
    
    func showErrorCompanyName(_ text: String) {
        self.companyName.showError(text)
    }
    
    func hideErrorCompanyName() {
        self.companyName.hideError()
    }
    
}
