//
//  CompanyView.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 17.12.2021.
//

import UIKit

protocol ICompanyListView: UIView {
    
    var getNumberOfRows: (() -> Int)? { get set }
    var getTextForCellAtRow: ((Int) -> String)? { get set }
    
    func updateTableView()
    
}

final class CompanyListView: UIView {
    
    private enum Constants {
        static let cellIdentifier = "Cell"
    }
    
    private let tableView = UITableView()
    
    var getNumberOfRows: (() -> Int)?
    var getTextForCellAtRow: ((Int) -> String)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
        self.configuireLayout()
    }
    
}

// MARK: Configuire view
extension CompanyListView {
    
    private func configureView() {
        self.backgroundColor = .systemBackground
        
        self.configuireTableView()
    }
    
    private func configuireTableView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundView = self.getBackgroundView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
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
extension CompanyListView {
    
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
    
//MARK: ICompanyListView
extension CompanyListView: ICompanyListView {
    
    func updateTableView() {
        self.tableView.reloadData()
    }
    
}

//MARK: UITableViewDataSource
extension CompanyListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.getNumberOfRows?() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = self.getTextForCellAtRow?(indexPath.row)
        cell.contentConfiguration  = configuration
        
        return cell
    }

}
