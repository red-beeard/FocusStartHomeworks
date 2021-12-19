//
//  EmployeesScreenView.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

import UIKit

protocol IEmployeesScreenView: UIView {
    func getTableView() -> UITableView
}

final class EmployeesScreenView: UIView {
    
    private let tableView = UITableView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuireView()
        self.configuireLayout()
    }
    
}

// MARK: Configuire view
extension EmployeesScreenView {
    
    private func configuireView() {
        self.backgroundColor = .systemBackground
        
        self.configuireTableView()
    }
    
    private func configuireTableView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundView = self.getBackgroundView()
    }
    
    private func getBackgroundView() -> UILabel {
        let noDataLabel = UILabel()
        noDataLabel.textAlignment = .center
        noDataLabel.textColor = .systemGray
        noDataLabel.text = "Нет данных"
        
        return noDataLabel
    }
    
}

// MARK: Configuire layout view
extension EmployeesScreenView {
    
    private func configuireLayout() {
        self.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}
    
//MARK: IEmployeesView
extension EmployeesScreenView: IEmployeesScreenView {
    
    func getTableView() -> UITableView {
        return self.tableView
    }
    
}
