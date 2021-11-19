//
//  DetailsViewController.swift
//  CollectionApp
//
//  Created by Red Beard on 19.11.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private enum Metrics {
        static let titleLabelFontSize = CGFloat(20)
        static let smallIndent = CGFloat(20)
    }
    
    var image: Image!
    
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configuireView()
        self.configuireLayout()
    }
    
    private func configuireView() {
        self.configurationStackView()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        self.title = "Details"
        self.view.backgroundColor = .systemBackground
    }
    
    private func configurationStackView() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.spacing = 8
        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: Metrics.titleLabelFontSize)
        titleLabel.text = "Нет изображения"
        self.stackView.addArrangedSubview(titleLabel)
        
        if let image = UIImage(named: self.image.filename),
           let ciImage = CIImage(image: image)
        {
            titleLabel.text = "Разрешение:"
            
            let descriptionLabel = UILabel()
            let height = Int(ciImage.extent.height)
            let width = Int(ciImage.extent.width)
            descriptionLabel.text = "\(height) x \(width)"
            
            self.stackView.addArrangedSubview(descriptionLabel)
        }
    }
    
    private func configuireLayout() {
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.smallIndent),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.smallIndent),
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true)
    }

}
