//
//  PhotoView.swift
//  CollectionAppWithArchitecture
//
//  Created by Red Beard on 26.11.2021.
//

import UIKit

final class PhotoView: UIView {
    
    private enum Metrics {
        static let cornerRadius = CGFloat(15)
        static let smallIndent = CGFloat(20)
        static let titleLabelFontSize = CGFloat(25)
        static let stackViewSpacing = CGFloat(30)
    }
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let detailsButton = UIButton()
    private let stackView = UIStackView()
    
    private var portraitConstraints = [NSLayoutConstraint]()
    private var landscapeConstraints = [NSLayoutConstraint]()
    
    var detailsButtonOnTouched: (() -> Void)?
    
    func configuireView() {
        self.configurationImageView()
        self.configurationTitleLabel()
        self.configurationDetailsButton()
        self.configurationStackView()
        
        self.backgroundColor = .systemBackground
        
        self.configuireLayout()
    }
    
    func setImageData(image: Image) {
        self.imageView.image = UIImage(named: image.filename)
        self.titleLabel.text = image.author
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        let orientation = UIDevice.current.orientation
        
        if orientation == .portrait {
            NSLayoutConstraint.deactivate(self.landscapeConstraints)
            NSLayoutConstraint.activate(self.portraitConstraints)
        } else {
            NSLayoutConstraint.deactivate(self.portraitConstraints)
            NSLayoutConstraint.activate(self.landscapeConstraints)
        }
    }
    
    private func configurationImageView() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.layer.cornerRadius = Metrics.cornerRadius
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
    }
    
    private func configurationTitleLabel() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textAlignment = .center
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.minimumScaleFactor = 0.5
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: Metrics.titleLabelFontSize)
    }
    
    private func configurationDetailsButton() {
        self.detailsButton.translatesAutoresizingMaskIntoConstraints = false
        self.detailsButton.setTitleColor(.systemBlue, for: .normal)
        self.detailsButton.setTitle("Show Details", for: .normal)
        self.detailsButton.addTarget(self, action: #selector(detailsButtonTapped), for: .touchUpInside)
    }
    
    private func configurationStackView() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.detailsButton)
        self.stackView.spacing = Metrics.stackViewSpacing
        self.stackView.axis = .vertical
    }
    
    private func configuireLayout() {
        self.addSubview(imageView)
        self.addSubview(stackView)
        
        self.createPortraitConstraints()
        self.createLandscapeConstraints()
        self.updateConstraints()
    }
    
    private func createPortraitConstraints() {
        self.portraitConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.smallIndent),
            self.imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.smallIndent),
            self.imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.smallIndent),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: Metrics.smallIndent),
            self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.smallIndent),
            self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.smallIndent),
        ]
    }
    
    private func createLandscapeConstraints() {
        self.landscapeConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.smallIndent),
            self.imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.smallIndent),
            self.imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.smallIndent),
            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: Metrics.smallIndent),
            self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.smallIndent),
        ]
    }
    
    @objc private func detailsButtonTapped() {
        self.detailsButtonOnTouched?()
    }
    
}
