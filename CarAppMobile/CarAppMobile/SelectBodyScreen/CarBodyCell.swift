//
//  CarBodyCell.swift
//  CarAppMobile
//
//  Created by Red Beard on 08.12.2021.
//

import UIKit

protocol ICarBodyCell: UITableViewCell {
    func setText(name: String)
    func setChecked(_ checked: Bool)
    func getChecked() -> Bool
}

final class CarBodyCell: UITableViewCell {
    
    private enum Metrics {
        static let checkBoxSize = CGFloat(16)
    }
    
    static let identifier = "CarBodyCell"
    
    private let label = UILabel()
    private let checkBox: ICheckBox
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.checkBox = CheckBox()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configuireCell()
    }
    
    private func configuireCell() {
        self.selectionStyle = .none
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.checkBox.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label)
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        self.addSubview(checkBox)
        NSLayoutConstraint.activate([
            self.checkBox.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.checkBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.checkBox.heightAnchor.constraint(equalToConstant: Metrics.checkBoxSize),
            self.checkBox.widthAnchor.constraint(equalToConstant: Metrics.checkBoxSize)
        ])
        
    }
    
}

extension CarBodyCell: ICarBodyCell {
    
    func setText(name: String) {
        self.label.text = name
    }
    
    func setChecked(_ checked: Bool) {
        self.checkBox.setChecked(checked)
    }
    
    func getChecked() -> Bool {
        self.checkBox.getChecked()
    }
    
}
