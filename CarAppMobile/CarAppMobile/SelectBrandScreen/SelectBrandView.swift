//
//  SelectBrandView.swift
//  CarAppMobile
//
//  Created by Red Beard on 03.12.2021.
//

import UIKit

protocol ISelectBrandView {
    
}

final class SelectBrandView: UIView {
    
    private enum Metrics {
        static let selectLabelFontSize = CGFloat(30)
        static let selectLabelFontWeight = UIFont.Weight(rawValue: 600)
        
        static let brandCarLabelFontSize = CGFloat(24)
        static let brandCarLabelFontWeight = UIFont.Weight(rawValue: 500)
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
    }
    
    private func configuireView() {
        self.configuireSelectLabel()
    }
    
    private func configuireSelectLabel() {
        selectLabel.translatesAutoresizingMaskIntoConstraints = false
        selectLabel.text = "Выберите"
        selectLabel.font = UIFont.systemFont(ofSize: Metrics.selectLabelFontSize,
                                             weight: Metrics.selectLabelFontWeight)
    }
    
    private func configuireBrandCarLabel() {
        brandCarLabel.translatesAutoresizingMaskIntoConstraints = false
        brandCarLabel.text = "Марку машины"
        brandCarLabel.font = UIFont.systemFont(ofSize: Metrics.brandCarLabelFontSize,
                                               weight: Metrics.brandCarLabelFontWeight)
    }
    
}

extension SelectBrandView: ISelectBrandView{
    
}
