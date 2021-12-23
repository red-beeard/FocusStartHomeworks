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
    func deleteRow(at id: UUID)
}

protocol CompaniesScreenTableAdapterDelegate: AnyObject {
    func onItemSelect(id: UUID)
    func onItemDelete(id: UUID)
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
    
    func deleteRow(at id: UUID) {
        let index = self.companies.firstIndex { $0.id == id }
        if let index = index {
            self.companies.remove(at: index)
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView?.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}


//MARK: UITableViewDelegate
extension CompaniesScreenTableAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.onItemSelect(id: self.companies[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить", handler: { (_, _, _) in
            self.delegate?.onItemDelete(id: self.companies[indexPath.row].id)
        })
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
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
