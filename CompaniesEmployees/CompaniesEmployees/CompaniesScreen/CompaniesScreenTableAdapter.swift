//
//  CompaniesScreenTableAdapter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 19.12.2021.
//

import UIKit

protocol ICompaniesScreenTableAdapter: AnyObject {
    var tableView: UITableView? { get set }
    var delegate: CompaniesScreenTableAdapterDelegate? { get set }
    func update(companies: [CompaniesScreenViewModel])
}

protocol CompaniesScreenTableAdapterDelegate: AnyObject {
    func onItemSelect(id: UUID)
}

final class CompaniesScreenTableAdapter: NSObject {
    
    private enum Constants {
        static let identifier = "cell"
    }
    
    private var companies = [CompaniesScreenViewModel]()
    weak var delegate: CompaniesScreenTableAdapterDelegate?
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: Constants.identifier)
        }
    }
    
}

extension CompaniesScreenTableAdapter: ICompaniesScreenTableAdapter {
    
    func update(companies: [CompaniesScreenViewModel]) {
        self.companies = companies
        
        self.tableView?.backgroundView?.isHidden = companies.count != 0
        self.tableView?.reloadData()
    }
    
}


//MARK: UITableViewDelegate
extension CompaniesScreenTableAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.onItemSelect(id: self.companies[indexPath.row].id)
    }
    
}


//MARK: UITableViewDataSource
extension CompaniesScreenTableAdapter: UITableViewDataSource {
    
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
