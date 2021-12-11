//
//  SelectBodyView.swift
//  CarAppMobile
//
//  Created by Red Beard on 07.12.2021.
//

import UIKit

protocol ISelectBodyView: UIView {
    
    var changeBodyHandler: ((Int) -> Void)? { get set }
    var calculateCostHandler: ((Int) -> Void)? { get set }
    
    func showActivityIndicator(_ show: Bool)
    func setNumberOfRowsInSection(_ number: Int)
    func setChecked(for index: Int)
    func setTextInCells(_ strings: [String])
    func setTextInCostLabel(_ string: String)
    func setImage(name: String)
    
}

final class SelectBodyView: UIView {
    
    private enum Metrics {
        static let largeFontSize = CGFloat(24)
        static let mediumVertivalSpacing = CGFloat(20)
        static let horizontalSpacing = CGFloat(20)
        
        static let tableViewRowHeight = CGFloat(60)
        
        static let calculateCostButtonHeight = CGFloat(50)
        
        static let green = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1)
    }

    private let carView: ICarView = CarView()
    private let selectBodyLabel = UILabel()
    private let tableView = UITableView()
    private let scrollView = UIScrollView()
    private let calculateCostButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var numberOfRowsInSection = 0
    private var tableViewHeight: NSLayoutConstraint?
    
    var changeBodyHandler: ((Int) -> Void)?
    var calculateCostHandler: ((Int) -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuireView()
        self.configuireLayout()
    }
    
    @objc private func onTouched() {
        guard let index = self.indexCheckedCell(for: .zero) else { return }
        self.calculateCostHandler?(index)
    }
    
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
    
    private func indexCheckedCell(for section: Int) -> Int? {
        for indexPath in getAllIndexPathsInSection(section: section) {
            let cell = tableView.cellForRow(at: indexPath) as! ICarBodyCell
            if cell.getChecked() {
                return indexPath.row
            }
        }
        return nil
    }
    
}

// MARK: Configuire view
extension SelectBodyView {
    
    private func configuireView() {
        self.configuireCarView()
        self.configuireSelectBodyLabel()
        self.configuireTableView()
        self.configuireCalculateCostButton()
        self.configuireScrollView()
        self.configuireActivityIndicator()
    }
    
    private func configuireCarView() {
        self.carView.translatesAutoresizingMaskIntoConstraints = false
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
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func configuireCalculateCostButton() {
        self.calculateCostButton.translatesAutoresizingMaskIntoConstraints = false
        self.calculateCostButton.backgroundColor = Metrics.green
        self.calculateCostButton.tintColor = .white
        self.calculateCostButton.setTitle("Рассчитать цену", for: .normal)
        self.calculateCostButton.layer.cornerRadius = Metrics.calculateCostButtonHeight / 2
        self.calculateCostButton.addTarget(self, action: #selector(onTouched), for: .touchUpInside)
    }
    
    private func configuireScrollView() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.showsVerticalScrollIndicator = false
    }
    
    private func configuireActivityIndicator() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

// MARK: Configuire layout

extension SelectBodyView {
    
    private func configuireLayout() {
        self.configuireLayoutCalculateCostButton()
        self.configuireLayoutActivityIndicator()
        self.configuireLayoutScrollView()
    }
    
    private func configuireLayoutScrollView() {
        self.addSubview(self.scrollView)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.horizontalSpacing),
            self.scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.horizontalSpacing),
            self.scrollView.bottomAnchor.constraint(equalTo: self.calculateCostButton.topAnchor)
        ])
        
        self.configuireLayoutCarView()
        self.configuireLayoutSelectBodyLabel()
        self.configuireLayoutTableView()
    }
    
    private func configuireLayoutCarView() {
        self.scrollView.addSubview(self.carView)
        
        NSLayoutConstraint.activate([
            self.carView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.carView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.carView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.carView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
    
    private func configuireLayoutSelectBodyLabel() {
        self.scrollView.addSubview(self.selectBodyLabel)
        
        NSLayoutConstraint.activate([
            self.selectBodyLabel.topAnchor.constraint(equalTo: self.carView.bottomAnchor, constant: Metrics.mediumVertivalSpacing),
            self.selectBodyLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.selectBodyLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.selectBodyLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
    
    private func configuireLayoutTableView() {
        self.scrollView.addSubview(self.tableView)
        
        self.tableViewHeight = self.tableView.heightAnchor.constraint(equalToConstant: Metrics.tableViewRowHeight * CGFloat(self.numberOfRowsInSection))
        self.tableViewHeight?.isActive = true

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.selectBodyLabel.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.tableView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
        ])
    }
    
    private func configuireLayoutCalculateCostButton() {
        self.addSubview(self.calculateCostButton)
        
        NSLayoutConstraint.activate([
            self.calculateCostButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.mediumVertivalSpacing),
            self.calculateCostButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.horizontalSpacing),
            self.calculateCostButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.horizontalSpacing),
            self.calculateCostButton.heightAnchor.constraint(equalToConstant: Metrics.calculateCostButtonHeight)
        ])
    }
    
    private func configuireLayoutActivityIndicator() {
        self.addSubview(self.activityIndicator)
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}

// MARK: UITableViewDataSource

extension SelectBodyView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: CarBodyCell.identifier, for: indexPath) as! ICarBodyCell
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

extension SelectBodyView: ISelectBodyView {
    
    func setChecked(for index: Int) {
        let indexPath = IndexPath(row: index, section: .zero)
        let cell = self.tableView.cellForRow(at: indexPath) as? ICarBodyCell
        cell?.setChecked(true)
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
    
    func setTextInCostLabel(_ string: String) {
        self.carView.setTextInCostLabel(string)
    }
    
    func setImage(name: String) {
        self.carView.setImage(name: name)
    }
    
    func showActivityIndicator(_ show: Bool) {
        self.subviews.forEach { $0.isHidden = show }
        
        show == true
            ? self.activityIndicator.startAnimating()
            : self.activityIndicator.stopAnimating()
    }
    
}
