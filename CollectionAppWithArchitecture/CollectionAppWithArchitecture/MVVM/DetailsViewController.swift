//
//  DetailsViewController.swift
//  CollectionAppWithArchitecture
//
//  Created by Red Beard on 29.11.2021.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    private enum Metrics {
        static let titleLabelFontSize = CGFloat(20)
        static let smallIndent = CGFloat(20)
        static let stackViewSpacing = CGFloat(8)
    }
    
    let viewModel: DetailsViewModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private let stackView = UIStackView()
    private let descriptionLabel = UILabel()
    
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
        
        self.viewModel.data.setNotify { [weak self] text in
            self?.descriptionLabel.text = text
        }
    }
    
    private func configurationStackView() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.spacing = Metrics.stackViewSpacing
        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: Metrics.titleLabelFontSize)
        titleLabel.text = "Разрешение:"
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(self.descriptionLabel)
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
