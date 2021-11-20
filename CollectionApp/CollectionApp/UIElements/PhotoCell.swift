//
//  PhotoCell.swift
//  CollectionApp
//
//  Created by Red Beard on 18.11.2021.
//

import UIKit

class PhotoCell: UITableViewCell {
    
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
    
    var imageData: Image? {
        didSet {
            guard let imageData = imageData else { return }
            self.photoImageView.image = UIImage(named: imageData.filename)
            self.titleLabel.text = imageData.author
        }
    }
    
    private let photoImageView = UIImageView()
    private let titleLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configuireCell()
        self.configuireLayout()
    }
    
    private func configuireCell() {
        self.photoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.photoImageView.layer.cornerRadius = Metrics.cornerRadius
        self.photoImageView.contentMode = .scaleAspectFill
        self.photoImageView.clipsToBounds = true
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.minimumScaleFactor = 0.5
    }
    
    private func configuireLayout() {
        self.addSubview(self.photoImageView)
        self.addSubview(self.titleLabel)
        
        NSLayoutConstraint.activate([
            self.photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.smallIndent),
            self.photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.smallIndent),
            self.photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.smallIndent),
            self.photoImageView.widthAnchor.constraint(equalTo: self.photoImageView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.photoImageView.trailingAnchor, constant: Metrics.smallIndent),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.smallIndent)
        ])
    }
    
}
