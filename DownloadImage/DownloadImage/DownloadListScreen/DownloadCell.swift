//
//  DownloadCell.swift
//  DownloadImage
//
//  Created by Red Beard on 12.12.2021.
//

import UIKit

protocol IDownloadCell: UICollectionViewCell {
    
    static var identifier: String { get }
    
    func setText(_ string: String)
    
}

final class DownloadCell: UICollectionViewCell {
    
    private enum Metrics {
        static let horizontalSpacing = CGFloat(10)
        static let cornerRadius = CGFloat(10)
    }
    
    static let identifier = "DownloadCell"
    
    private let label = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuireView()
        self.configurationLayout()
    }
    
    private func configuireView() {
        self.layer.cornerRadius = Metrics.cornerRadius
        self.backgroundColor = .systemFill
        
        self.configuireLabel()
    }
    
    private func configuireLabel() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.text = "Text"
    }
    
    private func configurationLayout() {
        self.addSubview(self.label)
        
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.horizontalSpacing),
            self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}

extension DownloadCell: IDownloadCell {
    
    func setText(_ string: String) {
        self.label.text = string
    }
    
}
