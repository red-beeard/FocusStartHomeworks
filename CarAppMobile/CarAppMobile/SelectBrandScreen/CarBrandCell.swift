//
//  CarBrandCell.swift
//  CarAppMobile
//
//  Created by Red Beard on 03.12.2021.
//

import UIKit

protocol ICarBrandCell {
    func setBrand(name: String)
}

final class CarBrandCell: UITableViewCell {
    
    private enum Metrics {
        static let greenViewSize = CGFloat(16)
        static let green = UIColor(red: 93, green: 176, blue: 117, alpha: 1)
        
        static let mediumIndent = CGFloat(16)
    }
    
    static let identifier = "CarBrandCell"
    
    let greenPoint = UIView()
    let brandName = UILabel()
    let selectLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configuireCell()
    }
    
    private func configuireCell() {
        self.configuireGreenView()
        self.configuireLabels()
        self.configuireLayout()
    }
    
    private func configuireGreenView() {
        self.greenPoint.translatesAutoresizingMaskIntoConstraints = false
        self.greenPoint.backgroundColor = Metrics.green
        self.greenPoint.layer.cornerRadius = Metrics.greenViewSize / CGFloat(2)
    }
    
    private func configuireLabels() {
        self.brandName.translatesAutoresizingMaskIntoConstraints = false
        self.selectLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.selectLabel.text = "Select"
    }
    
    private func configuireLayout() {
        self.addSubview(greenPoint)
        self.addSubview(brandName)
        self.addSubview(selectLabel)
        
        NSLayoutConstraint.activate([
            self.greenPoint.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.mediumIndent),
            self.greenPoint.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.brandName.leadingAnchor.constraint(equalTo: self.greenPoint.trailingAnchor, constant: Metrics.mediumIndent),
            self.brandName.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.greenPoint.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.mediumIndent),
            self.greenPoint.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}

extension CarBrandCell: ICarBrandCell {
    
    func setBrand(name: String) {
        self.brandName.text = name
    }
    
}
