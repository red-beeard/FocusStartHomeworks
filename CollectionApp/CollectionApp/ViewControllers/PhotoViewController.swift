//
//  PhotoViewController.swift
//  CollectionApp
//
//  Created by Red Beard on 18.11.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    private enum Metrics {
        static let cornerRadius = CGFloat(15)
        static let smallIndent = CGFloat(20)
        static let titleLabelFontSize = CGFloat(25)
        static let stackViewSpacing = CGFloat(30)
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
    private let detailsButton = UIButton()
    private let stackView = UIStackView()
    
    private var portraitConstraints = [NSLayoutConstraint]()
    private var landscapeConstraints = [NSLayoutConstraint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configuireView()
        self.configuireLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.updateConstraints()
        self.view.layoutIfNeeded()
    }
    
    private func configuireView() {
        self.configurationImageView()
        self.configurationTitleLabel()
        self.configurationDetailsButton()
        self.configurationStackView()
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.largeTitleDisplayMode = .never
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
        self.view.addSubview(imageView)
        self.view.addSubview(stackView)
        
        self.createPortraitConstraints()
        self.createLandscapeConstraints()
        self.updateConstraints()
    }
    
    private func createPortraitConstraints() {
        self.portraitConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Metrics.smallIndent),
            self.imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.smallIndent),
            self.imageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.smallIndent),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: Metrics.smallIndent),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.smallIndent),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.smallIndent),
        ]
    }
    
    private func createLandscapeConstraints() {
        self.landscapeConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Metrics.smallIndent),
            self.imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.smallIndent),
            self.imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.smallIndent),
            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: Metrics.smallIndent),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.smallIndent),
        ]
    }
    
    private func updateConstraints() {
        let orientation = UIDevice.current.orientation
        
        if orientation == .portrait {
            NSLayoutConstraint.deactivate(self.landscapeConstraints)
            NSLayoutConstraint.activate(self.portraitConstraints)
        } else {
            NSLayoutConstraint.deactivate(self.portraitConstraints)
            NSLayoutConstraint.activate(self.landscapeConstraints)
        }
    }
    
    @objc private func detailsButtonTapped() {
        let detailsVC = DetailsViewController()
        detailsVC.image = self.image
        let navigationVC = UINavigationController(rootViewController: detailsVC)
        self.present(navigationVC, animated: true)
    }
    
}
