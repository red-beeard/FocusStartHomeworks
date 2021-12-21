//
//  EmployeesScreenTableAdapter.swift
//  CompaniesEmployees
//
//  Created by Red Beard on 20.12.2021.
//

import UIKit

protocol IEmployeesScreenTableAdapter {
    var tableView: UITableView? { get set }
    func update(employees: [EmployeesScreenViewModel])
}

final class EmployeesScreenTableAdapter: NSObject {
    
    private enum Constants {
        static let identifier = "cell"
    }
    
    private var employees = [EmployeesScreenViewModel]()
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
    
}


//MARK: IEmployeeScreenTableAdapter
extension EmployeesScreenTableAdapter: IEmployeesScreenTableAdapter {
    
    func update(employees: [EmployeesScreenViewModel]) {
        self.employees = employees
        
        self.tableView?.backgroundView?.isHidden = employees.count != 0
        self.tableView?.reloadData()
    }
    
}
