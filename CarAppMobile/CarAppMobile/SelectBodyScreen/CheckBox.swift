//
//  RadioButton.swift
//  CarAppMobile
//
//  Created by Red Beard on 08.12.2021.
//

import UIKit

protocol ICheckBox: UIView {
    func setChecked(_ checked: Bool)
    
    func getChecked() -> Bool
}

final class CheckBox: UIView {
    
    private enum Metrics {
        static let spacing = CGFloat(3)
        static let borderWidth = CGFloat(2)
        static let green = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1)
        static let greenCG = CGColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1)
    }
    
    override var bounds: CGRect {
        didSet {
            self.configuireCornerRadius()
        }
    }
    
    private let circle = UIView()
    
    private var checked: Bool {
        didSet {
            if self.checked != oldValue {
                UIView.animate(withDuration: 0.5) {
                    self.circle.alpha = self.checked ? 1 : 0
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        self.checked = false
        super.init(frame: frame)
        self.configuire()
    }
    
    private func configuire() {
        self.layer.borderWidth = Metrics.borderWidth
        self.layer.borderColor = Metrics.greenCG
        self.circle.backgroundColor = Metrics.green
        self.circle.translatesAutoresizingMaskIntoConstraints = false
        self.circle.alpha = 0
        
        self.addSubview(self.circle)
        NSLayoutConstraint.activate([
            self.circle.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.spacing),
            self.circle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.spacing),
            self.circle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.spacing),
            self.circle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.spacing),
        ])
    }
    
    private func configuireCornerRadius() {
        let minSide = min(self.bounds.height, self.bounds.width)
        self.layer.cornerRadius = minSide / 2
        self.circle.layer.cornerRadius = minSide / 2 - Metrics.spacing
    }
    
}

extension CheckBox: ICheckBox {
    
    func setChecked(_ checked: Bool) {
        self.checked = checked
    }
    
    func getChecked() -> Bool {
        self.checked
    }
    
}
