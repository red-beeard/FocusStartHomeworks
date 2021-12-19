//
//  CompanyListTableAdapter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

import UIKit

protocol ICompaniesTableAdapter: AnyObject {
    var tableView: UITableView? { get set }
    func update(companies: [CompaniesViewModel])
}

final class CompaniesTableAdapter: NSObject {
    
    private enum Constants {
        static let identifier = "cell"
    }
    
    private var companies = [CompaniesViewModel]()
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: Constants.identifier)
        }
    }
    
}

extension CompaniesTableAdapter: ICompaniesTableAdapter {
    
    func update(companies: [CompaniesViewModel]) {
        self.companies = companies
        self.tableView?.reloadData()
    }
    
}


//MARK: UITableViewDelegate
extension CompaniesTableAdapter: UITableViewDelegate {
    
}


//MARK: UITableViewDataSource
extension CompaniesTableAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier, for: indexPath)
        
        let company = self.companies[indexPath.row]
        var configuration = cell.defaultContentConfiguration()
        configuration.text = company.name
        cell.contentConfiguration  = configuration
        
        return cell
    }
    
}
