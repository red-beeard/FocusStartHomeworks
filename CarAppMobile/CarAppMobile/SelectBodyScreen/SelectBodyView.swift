//
//  SelectBodyView.swift
//  CarAppMobile
//
//  Created by Red Beard on 07.12.2021.
//

import UIKit

protocol ISelectBodyView: UIView {
    
}

class SelectBodyView: UIView {
    
    private enum Metrics {
        static let largeFontSize = CGFloat(24)
        static let mediumVertivalSpacing = CGFloat(20)
        static let smallVertivalSpacing = CGFloat(8)
        static let horizontalSpacing = CGFloat(20)
        
        static let calculateCostButtonHeight = CGFloat(50)
        
        static let green = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1)
    }

    private let carImageView = UIImageView()
    private let costTitleLabel = UILabel()
    private let costLabel = UILabel()
    private let selectBodyLabel = UILabel()
    private let tableView = UITableView()
    private let scrollView = UIScrollView()
    private let calculateCostButton = UIButton()
    
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
extension SelectBodyView {
    
    private func configuireView() {
        self.configuireImageView()
        self.configuireCostTitleLabel()
        self.configuireCostLabel()
        self.configuireSelectBodyLabel()
        self.configuireTableView()
        self.configuireCalculateCostButton()
        self.configuireScrollView()
    }
    
    private func configuireImageView() {
        self.carImageView.translatesAutoresizingMaskIntoConstraints = false
        self.carImageView.contentMode = .scaleAspectFill
        self.carImageView.clipsToBounds = true
        
        self.carImageView.backgroundColor = .green
    }
    
    private func configuireCostTitleLabel() {
        self.costTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.costTitleLabel.font = UIFont.systemFont(ofSize: Metrics.largeFontSize)
        self.costTitleLabel.text = "Цена"
    }
    
    private func configuireCostLabel() {
        self.costLabel.translatesAutoresizingMaskIntoConstraints = false
        self.costLabel.font = UIFont.systemFont(ofSize: UIFont.labelFontSize, weight: .semibold)
        self.costLabel.text = "Нет данных"
    }
    
    private func configuireSelectBodyLabel() {
        self.selectBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.selectBodyLabel.textAlignment = .center
        self.selectBodyLabel.font = UIFont.systemFont(ofSize: Metrics.largeFontSize)
        self.selectBodyLabel.text = "Выберите тип кузова"
    }
    
    private func configuireTableView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configuireCalculateCostButton() {
        self.calculateCostButton.translatesAutoresizingMaskIntoConstraints = false
        self.calculateCostButton.backgroundColor = Metrics.green
        self.calculateCostButton.tintColor = .white
        self.calculateCostButton.setTitle("Рассчитать цену", for: .normal)
        self.calculateCostButton.layer.cornerRadius = Metrics.calculateCostButtonHeight / 2
    }
    
    private func configuireScrollView() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.showsVerticalScrollIndicator = false
    }
    
}

// MARK: Configuire layout

extension SelectBodyView {
    
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
        
        self.configuireLayoutCarImageView()
        self.configuireLayoutCost()
        self.configuireLayoutSelectBodyLabel()
        self.configuireLayoutTableView()
    }
    
    private func configuireLayoutCarImageView() {
        self.scrollView.addSubview(self.carImageView)
        
        NSLayoutConstraint.activate([
            self.carImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.carImageView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.carImageView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.carImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1 / 3),
            self.carImageView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
    
    private func configuireLayoutCost() {
        let vStack = UIStackView(arrangedSubviews: [self.costTitleLabel, self.costLabel])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.spacing = Metrics.smallVertivalSpacing
        vStack.axis = .vertical
        vStack.alignment = .leading
        self.scrollView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: self.carImageView.bottomAnchor, constant: Metrics.mediumVertivalSpacing),
            vStack.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            vStack.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
    
    private func configuireLayoutSelectBodyLabel() {
        self.scrollView.addSubview(self.selectBodyLabel)
        
        NSLayoutConstraint.activate([
            self.selectBodyLabel.topAnchor.constraint(equalTo: self.costLabel.bottomAnchor, constant: Metrics.mediumVertivalSpacing),
            self.selectBodyLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.selectBodyLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.selectBodyLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
    
    private func configuireLayoutTableView() {
        self.scrollView.addSubview(self.tableView)

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.selectBodyLabel.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.tableView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
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

extension SelectBodyView: ISelectBodyView {
    
}
