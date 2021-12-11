//
//  SelectBodyView.swift
//  CarAppMobile
//
//  Created by Red Beard on 11.12.2021.
//

import UIKit

protocol ISelectBodyView: UIView {
    
    var changeBodyHandler: ((Int) -> Void)? { get set }
    
    func setNumberOfRowsInSection(_ number: Int)
    func indexCheckedCell(for section: Int) -> Int?
    func setChecked(for index: Int)
    func setTextInCells(_ strings: [String])
    
}

final class SelectBodyView: UIView {
    
    private enum Metrics {
        static let largeFontSize = CGFloat(24)
        static let mediumVertivalSpacing = CGFloat(20)
        
        static let tableViewRowHeight = CGFloat(60)
    }

    private let selectBodyLabel = UILabel()
    private let tableView = UITableView()
    
    private var numberOfRowsInSection = 0
    private var tableViewHeight: NSLayoutConstraint?
    
    var changeBodyHandler: ((Int) -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuireView()
        self.configuireLayoutView()
    }

}

// MARK: Сonfiguire view
extension SelectBodyView {
    
    private func configuireView() {
        self.configuireSelectBodyLabel()
        self.configuireTableView()
    }
    
    private func configuireSelectBodyLabel() {
        self.selectBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.selectBodyLabel.textAlignment = .center
        self.selectBodyLabel.font = UIFont.systemFont(ofSize: Metrics.largeFontSize)
        self.selectBodyLabel.text = "Выберите тип кузова"
    }
    
    private func configuireTableView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(CarBodyCell.self, forCellReuseIdentifier: CarBodyCell.identifier)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = Metrics.tableViewRowHeight
        self.tableView.bounces = false
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
    }
    
}

// MARK: Configuire layout
extension SelectBodyView {
    
    private func configuireLayoutView() {
        self.configuireLayoutSelectBodyLabel()
        self.configuireLayoutTableView()
    }
    
    private func configuireLayoutSelectBodyLabel() {
        self.addSubview(self.selectBodyLabel)
        
        NSLayoutConstraint.activate([
            self.selectBodyLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.selectBodyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.selectBodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func configuireLayoutTableView() {
        self.addSubview(self.tableView)
        
        self.tableViewHeight = self.tableView.heightAnchor.constraint(equalToConstant: Metrics.tableViewRowHeight * CGFloat(self.numberOfRowsInSection))
        self.tableViewHeight?.isActive = true

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.selectBodyLabel.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

// MARK: Methods for work with UITableView
extension SelectBodyView {
    
    private func getAllIndexPathsInSection(section: Int) -> [IndexPath] {
        let count = self.tableView.numberOfRows(inSection: section)
        return (0 ..< count).map { IndexPath(row: $0, section: section) }
    }
    
    private func updateTableView() {
        self.tableViewHeight?.constant = Metrics.tableViewRowHeight * CGFloat(self.numberOfRowsInSection)
        self.tableView.layoutIfNeeded()
        self.tableView.reloadData()
    }
    
    private func deselectAllRows(for section: Int) {
        for indexPath in getAllIndexPathsInSection(section: section) {
            let cell = tableView.cellForRow(at: indexPath) as! ICarBodyCell
            if cell.getChecked() {
                cell.setChecked(false)
            }
        }
    }
    
}

extension SelectBodyView: ISelectBodyView {
    
    func setChecked(for index: Int) {
        let indexPath = IndexPath(row: index, section: .zero)
        let cell = self.tableView.cellForRow(at: indexPath) as? ICarBodyCell
        cell?.setChecked(true)
    }
    
    func indexCheckedCell(for section: Int) -> Int? {
        for indexPath in getAllIndexPathsInSection(section: section) {
            let cell = tableView.cellForRow(at: indexPath) as! ICarBodyCell
            if cell.getChecked() {
                return indexPath.row
            }
        }
        return nil
    }
    
    func setNumberOfRowsInSection(_ number: Int) {
        self.numberOfRowsInSection = number
        self.updateTableView()
    }
    
    func setTextInCells(_ strings: [String]) {
        for indexPath in getAllIndexPathsInSection(section: .zero) {
            let cell = self.tableView.cellForRow(at: indexPath) as! ICarBodyCell
            cell.setText(name: strings[indexPath.row])
        }
    }
    
}

extension SelectBodyView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deselectAllRows(for: indexPath.section)
        
        let cell = tableView.cellForRow(at: indexPath) as! ICarBodyCell
        cell.setChecked(true)
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.changeBodyHandler?(indexPath.row)
    }
    
}

extension SelectBodyView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: CarBodyCell.identifier, for: indexPath) as! ICarBodyCell
    }
    
}
