//
//  TextFieldWithError.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 21.12.2021.
//

import UIKit

final class TextFieldWithError: UIView {
    
    private enum Constants {
        static let stackSpacing = CGFloat(8)
        static let titleFontSize = CGFloat(20)
        static let textFieldBorderWidth = CGFloat(1)
        static let textFieldCornerRadius = CGFloat(5)
        static let errorLabelFontSize = CGFloat(12)
    }
    
    let titleLabel = UILabel()
    let textField = UITextField()
    let errorLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuireView()
        self.configuireViewLayout()
    }
    
    func showError(_ text: String?) {
        self.textField.layer.borderColor = UIColor.systemRed.cgColor
        self.errorLabel.text = text
        self.errorLabel.isHidden = false
    }
    
    func hideError() {
        self.textField.layer.borderColor = UIColor.separator.cgColor
        self.errorLabel.isHidden = true
    }
    
}

//MARK: Configuire view
extension TextFieldWithError {
    
    private func configuireView() {
        self.configuireTitleLabel()
        self.configuireTextField()
        self.configuireErrorLabel()
    }
    
    private func configuireTitleLabel() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textAlignment = .left
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
    }
    
    private func configuireTextField() {
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.borderStyle = .roundedRect
        self.textField.layer.borderColor = UIColor.separator.cgColor
        self.textField.layer.borderWidth = Constants.textFieldBorderWidth
        self.textField.layer.cornerRadius = Constants.textFieldCornerRadius
    }
    
    private func configuireErrorLabel() {
        self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorLabel.textColor = .systemRed
        self.errorLabel.textAlignment = .left
        self.errorLabel.font = UIFont.systemFont(ofSize: Constants.errorLabelFontSize)
        self.errorLabel.isHidden = true
    }
    
}

//MARK: Configuire view layout
extension TextFieldWithError {
    
    private func configuireViewLayout() {
        let vStack = UIStackView(arrangedSubviews: [self.titleLabel, self.textField, self.errorLabel])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.spacing = Constants.stackSpacing
        self.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: self.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}
