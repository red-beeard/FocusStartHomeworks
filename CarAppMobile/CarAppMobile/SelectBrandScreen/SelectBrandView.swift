//
//  SelectBrandView.swift
//  CarAppMobile
//
//  Created by Red Beard on 03.12.2021.
//

import UIKit

protocol ISelectBrandView: UIView {
    
}

final class SelectBrandView: UIView {
    
    private enum Metrics {
        static let selectLabelFontSize = CGFloat(30)
        static let selectLabelTop = CGFloat(20)
        
        static let brandCarLabelFontSize = CGFloat(24)
        static let brandCarLabelTop = CGFloat(40)
        static let brandCarLabelLTIndent = CGFloat(16)
    }
    
    private let selectLabel = UILabel()
    private let brandCarLabel = UILabel()
    private let tableView = UITableView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuireView()
        self.configuireLayout()
    }
    
    private func configuireView() {
        self.configuireSelectLabel()
        self.configuireBrandCarLabel()
    }
    
    private func configuireSelectLabel() {
        self.selectLabel.translatesAutoresizingMaskIntoConstraints = false
        self.selectLabel.text = "Выберите"
        self.selectLabel.font = UIFont.systemFont(ofSize: Metrics.selectLabelFontSize, weight: .semibold)
    }
    
    private func configuireBrandCarLabel() {
        self.brandCarLabel.translatesAutoresizingMaskIntoConstraints = false
        self.brandCarLabel.text = "Марку машины"
        self.brandCarLabel.font = UIFont.systemFont(ofSize: Metrics.brandCarLabelFontSize, weight: .medium)
    }
    
    private func configuireLayout() {
        self.addSubview(selectLabel)
        self.addSubview(brandCarLabel)
        
        NSLayoutConstraint.activate([
            self.selectLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.selectLabelTop),
            self.selectLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.brandCarLabel.topAnchor.constraint(equalTo: self.selectLabel.bottomAnchor, constant: Metrics.brandCarLabelTop),
            self.brandCarLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.brandCarLabelLTIndent),
            self.brandCarLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.brandCarLabelLTIndent)
        ])
    }
    
}

extension SelectBrandView: ISelectBrandView {
    
}
