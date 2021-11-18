//
//  PhotoCell.swift
//  CollectionApp
//
//  Created by Red Beard on 18.11.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    private enum Metrics {
        static let cornerRadius = CGFloat(15)
        static let smallIndent = CGFloat(10)
    }
    
    static let identifier = "photoCell"
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.alpha = self.isHighlighted ? 0.5 : 1.0
            }
        }
    }
    
    var image: Image? {
        didSet {
            guard let image = image else { return }
            self.imageView.image = UIImage(named: image.filename)
            self.titleLabel.text = image.author
        }
    }
    
    
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configuireCell()
        configuireLayout()
    }
    
    private func configuireCell() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.layer.cornerRadius = Metrics.cornerRadius
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textAlignment = .center
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.minimumScaleFactor = 0.5
        
        self.backgroundColor = .systemFill
        self.layer.cornerRadius = Metrics.cornerRadius
    }
    
    private func configuireLayout() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.smallIndent),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.smallIndent),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.smallIndent),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: self.frame.height * 0.4),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.smallIndent),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.smallIndent)
        ])
    }
    
}
