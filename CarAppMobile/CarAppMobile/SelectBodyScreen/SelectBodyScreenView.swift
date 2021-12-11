//
//  SelectBodyScreenView.swift
//  CarAppMobile
//
//  Created by Red Beard on 07.12.2021.
//

import UIKit

protocol ISelectBodyScreenView: UIView {
    
    var calculateCostHandler: ((Int) -> Void)? { get set }
    
    func setHideAllSubviews(_ hide: Bool)
    
    func setNumberOfRowsInSection(_ number: Int)
    func setChangeBodyHandler(_ handler: @escaping ((Int) -> Void))
    func setChecked(for index: Int)
    func setTextInCells(_ strings: [String])
    
    func setTextInCostLabel(_ string: String)
    func setImage(name: String)
    
}

final class SelectBodyScreenView: UIView {
    
    private enum Metrics {
        static let largeFontSize = CGFloat(24)
        static let mediumVertivalSpacing = CGFloat(20)
        static let horizontalSpacing = CGFloat(20)
        
        static let tableViewRowHeight = CGFloat(60)
        
        static let calculateCostButtonHeight = CGFloat(50)
        
        static let green = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1)
    }

    private let carView: ICarView = CarView()
    private let selectBodyView: ISelectBodyView = SelectBodyView()
    private let scrollView = UIScrollView()
    private let calculateCostButton = UIButton()
    
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
        guard let index = self.selectBodyView.indexCheckedCell(for: .zero) else { return }
        self.calculateCostHandler?(index)
    }
    
}

// MARK: Configuire view
extension SelectBodyScreenView {
    
    private func configuireView() {
        self.configuireCarView()
        self.configuireSelectBodyView()
        self.configuireCalculateCostButton()
        self.configuireScrollView()
    }
    
    private func configuireCarView() {
        self.carView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configuireSelectBodyView() {
        self.selectBodyView.translatesAutoresizingMaskIntoConstraints = false
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
    
}

// MARK: Configuire layout

extension SelectBodyScreenView {
    
    private func configuireLayout() {
        self.configuireLayoutCalculateCostButton()
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
        self.configuireLayoutSelectBodyView()
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
    
    private func configuireLayoutSelectBodyView() {
        self.scrollView.addSubview(self.selectBodyView)
        
        NSLayoutConstraint.activate([
            self.selectBodyView.topAnchor.constraint(equalTo: self.carView.bottomAnchor, constant: Metrics.mediumVertivalSpacing),
            self.selectBodyView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.selectBodyView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.selectBodyView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.selectBodyView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
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

}

// MARK: UITableViewDataSource


extension SelectBodyScreenView: ISelectBodyScreenView {
    
    func setChangeBodyHandler(_ handler: @escaping ((Int) -> Void)) {
        self.selectBodyView.changeBodyHandler = handler
    }
    
    func setChecked(for index: Int) {
        self.selectBodyView.setChecked(for: index)
    }
    
    func setNumberOfRowsInSection(_ number: Int) {
        self.selectBodyView.setNumberOfRowsInSection(number)
    }
    
    func setTextInCells(_ strings: [String]) {
        self.selectBodyView.setTextInCells(strings)
    }
    
    func setTextInCostLabel(_ string: String) {
        self.carView.setTextInCostLabel(string)
    }
    
    func setImage(name: String) {
        self.carView.setImage(name: name)
    }
    
    func setHideAllSubviews(_ hide: Bool) {
        self.subviews.forEach { $0.isHidden = hide }
    }
    
}
