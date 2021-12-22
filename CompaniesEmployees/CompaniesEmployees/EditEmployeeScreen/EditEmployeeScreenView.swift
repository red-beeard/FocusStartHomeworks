//
//  AddCompanyScreenView.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 21.12.2021.
//

import UIKit

protocol IEditEmployeeScreenView: UIView {
    var checkTextFields: (() -> Void)? { get set }
    
    func getViewModel() -> EditEmployeeViewModel
    func setViewModel(viewModel: EditEmployeeViewModel)
    
    func showErrorEmployeeName(_ text: String)
    func hideErrorEmployeeName()
    
    func showErrorEmployeeAge(_ text: String)
    func hideErrorEmployeeAge()
    
    func showErrorEmployeeExperience(_ text: String)
    func hideErrorEmployeeExperience()
}

final class EditEmployeeScreenView: UIView {
    
    private enum Constants {
        static let spacing = CGFloat(20)
        static let stackSpacing = CGFloat(8)
    }
    
    private let employeeName = TextFieldWithError()
    private let employeeAge = TextFieldWithError()
    private let employeeExperience = TextFieldWithError()
    
    var checkTextFields: (() -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuireView()
        self.configuireViewLayout()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.checkTextFields?()
    }
    
}

//MARK: Configuire view
extension EditEmployeeScreenView {
    
    private func configuireView() {
        self.backgroundColor = .systemBackground
        self.configuireEmployeeName()
        self.configuireEmployeeAge()
        self.configuireEmployeeExperience()
    }
    
    private func configuireEmployeeName() {
        self.employeeName.translatesAutoresizingMaskIntoConstraints = false
        self.employeeName.titleLabel.text = "Имя сотрудника"
        self.employeeName.textField.placeholder = "Имя сотрудника"
        self.employeeName.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func configuireEmployeeAge() {
        self.employeeAge.translatesAutoresizingMaskIntoConstraints = false
        self.employeeAge.titleLabel.text = "Возраст сотрудника"
        self.employeeAge.textField.placeholder = "Возраст сотрудника"
        self.employeeAge.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func configuireEmployeeExperience() {
        self.employeeExperience.translatesAutoresizingMaskIntoConstraints = false
        self.employeeExperience.titleLabel.text = "Стаж сотрудника"
        self.employeeExperience.textField.placeholder = "Стаж сотрудника"
        self.employeeExperience.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
}

//MARK: Configuire view
extension EditEmployeeScreenView {
    
    private func configuireViewLayout() {
        let vStack = UIStackView(arrangedSubviews: [self.employeeName, self.employeeAge, self.employeeExperience])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.spacing = Constants.stackSpacing
        self.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.spacing),
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.spacing),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.spacing),
        ])
    }
    
}

extension EditEmployeeScreenView: IEditEmployeeScreenView {
    
    func getViewModel() -> EditEmployeeViewModel {
        return EditEmployeeViewModel(
            name: self.employeeName.textField.text,
            age: self.employeeAge.textField.text,
            experience: self.employeeExperience.textField.text
        )
    }
    
    func setViewModel(viewModel: EditEmployeeViewModel) {
        self.employeeName.textField.text = viewModel.name
        self.employeeAge.textField.text = viewModel.age
        self.employeeExperience.textField.text = viewModel.experience
    }
    
    func showErrorEmployeeName(_ text: String) {
        self.employeeName.showError(text)
    }
    
    func hideErrorEmployeeName() {
        self.employeeName.hideError()
    }
    
    func showErrorEmployeeAge(_ text: String) {
        self.employeeAge.showError(text)
    }
    
    func hideErrorEmployeeAge() {
        self.employeeAge.hideError()
    }
    
    func showErrorEmployeeExperience(_ text: String) {
        self.employeeExperience.showError(text)
    }
    
    func hideErrorEmployeeExperience() {
        self.employeeExperience.hideError()
    }
    
}
