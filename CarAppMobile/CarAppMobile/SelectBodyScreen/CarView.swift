//
//  CostView.swift
//  CarAppMobile
//
//  Created by Red Beard on 11.12.2021.
//

import UIKit

protocol ICarView: UIView {
    func setImage(name: String)
    func setTextInCostLabel(_ string: String)
}

final class CarView: UIView {
    
    private enum Metrics {
        static let largeFontSize = CGFloat(24)
        static let smallVertivalSpacing = CGFloat(8)
        static let mediumVertivalSpacing = CGFloat(20)
    }

    private let carImageView = UIImageView()
    private let costTitleLabel = UILabel()
    private let costLabel = UILabel()
    
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
extension CarView {
    
    private func configuireView() {
        self.configuireImageView()
        self.configuireCostTitleLabel()
        self.configuireCostLabel()
    }
    
    private func configuireImageView() {
        self.carImageView.translatesAutoresizingMaskIntoConstraints = false
        self.carImageView.contentMode = .scaleAspectFill
        self.carImageView.clipsToBounds = true
        self.carImageView.backgroundColor = .systemFill
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
    
}

// MARK: Configuire layout
extension CarView {
    
    private func configuireLayout() {
        self.configuireLayoutCarImageView()
        self.configuireLayoutCostLabels()
    }
    
    private func configuireLayoutCarImageView() {
        self.addSubview(self.carImageView)
        let screenHeight = UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            self.carImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.carImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.carImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.carImageView.heightAnchor.constraint(equalToConstant: screenHeight / 4)
        ])
    }
    
    private func configuireLayoutCostLabels() {
        let vStack = UIStackView(arrangedSubviews: [self.costTitleLabel, self.costLabel])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.spacing = Metrics.smallVertivalSpacing
        vStack.axis = .vertical
        vStack.alignment = .leading
        self.addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: self.carImageView.bottomAnchor, constant: Metrics.mediumVertivalSpacing),
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

// MARK: ICostView
extension CarView: ICarView {
    
    func setImage(name: String) {
        self.carImageView.image = UIImage(named: name)
    }
    
    func setTextInCostLabel(_ string: String) {
        self.costLabel.text = string
    }
    
}
