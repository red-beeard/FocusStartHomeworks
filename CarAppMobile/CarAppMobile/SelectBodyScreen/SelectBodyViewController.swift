//
//  SelectBodyViewController.swift
//  CarAppMobile
//
//  Created by Red Beard on 07.12.2021.
//

import UIKit

protocol ISelectBodyViewController: UIViewController {
    var backButtonTouchedHandler: (() -> Void)? { get set }
    func setCarBrand(index: Int)
    func showActivityIndicator(_ show: Bool)
}

final class SelectBodyViewController: UIViewController {
    
    private enum Metrics {
        static let green = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1)
    }
    
    private let selectBodyView: ISelectBodyScreenView
    private let activityIndicator: UIActivityIndicatorView
    private let presenter: ISelectBodyPresenter
    
    var backButtonTouchedHandler: (() -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: ISelectBodyPresenter) {
        self.presenter = presenter
        self.selectBodyView = SelectBodyScreenView(frame: .zero)
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, view: self.selectBodyView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configuireView()
        self.addBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.loadData()
    }
    
    private func configuireView() {
        self.view.backgroundColor = .systemBackground
        
        self.configuireMainView()
        self.configuireActivityIndicator()
    }
    
    private func configuireMainView() {
        self.selectBodyView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.selectBodyView)
        
        NSLayoutConstraint.activate([
            self.selectBodyView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.selectBodyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.selectBodyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.selectBodyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func configuireActivityIndicator() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.activityIndicator)
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    private func addBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTouched))
        backButton.tintColor = Metrics.green
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTouched() {
        self.backButtonTouchedHandler?()
    }

}

extension SelectBodyViewController: ISelectBodyViewController {
    
    func setCarBrand(index: Int) {
        self.presenter.setCarBrand(index: index)
    }
    
    func showActivityIndicator(_ show: Bool) {
        show == true
            ? self.activityIndicator.startAnimating()
            : self.activityIndicator.stopAnimating()
    }
    
}
