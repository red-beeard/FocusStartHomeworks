//
//  EmployeesScreenTableAdapter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 20.12.2021.
//

import UIKit

protocol IEmployeesScreenTableAdapter {
    var tableView: UITableView? { get set }
    var delegate: EmployeesScreenTableAdapterDelegate? { get set }
    func update(employees: [EmployeesScreenViewModel])
    func deleteRow(at id: UUID)
}

protocol EmployeesScreenTableAdapterDelegate {
    func onItemSelect(id: UUID)
    func onItemDelete(id: UUID)
}

final class EmployeesScreenTableAdapter: NSObject {
    
    private enum Constants {
        static let identifier = "cell"
    }
    
    private var employees = [EmployeesScreenViewModel]()
    var delegate: EmployeesScreenTableAdapterDelegate?
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: Constants.identifier)
        }
    }
    
}

//MARK: UITableViewDataSource
extension EmployeesScreenTableAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier, for: indexPath)
        
        let employee = self.employees[indexPath.row]
        var configuration = cell.defaultContentConfiguration()
        
        configuration.text = employee.name
        if let experience = employee.experience {
            configuration.secondaryText = "\(employee.age) лет, Cтаж: \(experience) лет"
        } else {
            configuration.secondaryText = "\(employee.age) лет, Без опыта"
        }
        cell.contentConfiguration  = configuration
        
        return cell
    }
    
    
}

//MARK: UITableViewDelegate
extension EmployeesScreenTableAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.onItemSelect(id: self.employees[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить", handler: { (_, _, _) in
            self.delegate?.onItemDelete(id: self.employees[indexPath.row].id)
        })
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}


//MARK: IEmployeeScreenTableAdapter
extension EmployeesScreenTableAdapter: IEmployeesScreenTableAdapter {
    
    func update(employees: [EmployeesScreenViewModel]) {
        self.employees = employees
        
        self.tableView?.backgroundView?.isHidden = employees.count != 0
        self.tableView?.reloadData()
    }
    
    func deleteRow(at id: UUID) {
        let index = self.employees.firstIndex { $0.id == id }
        if let index = index {
            self.employees.remove(at: index)
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView?.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
