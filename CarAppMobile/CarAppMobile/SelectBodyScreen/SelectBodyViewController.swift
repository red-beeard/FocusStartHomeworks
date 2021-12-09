//
//  SelectBodyViewController.swift
//  CarAppMobile
//
//  Created by Red Beard on 07.12.2021.
//

import UIKit

protocol ISelectBodyViewController: UIViewController {
    func setCarBrand(index: Int)
}

final class SelectBodyViewController: UIViewController {
    
    private enum Metrics {
        static let green = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1)
    }
    
    let selectBodyView: ISelectBodyView
    let presenter: ISelectBodyPresenter
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: ISelectBodyPresenter) {
        self.presenter = presenter
        self.selectBodyView = SelectBodyView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, view: self.selectBodyView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = Metrics.green
        self.configuireView()
    }
    
    private func configuireView() {
        self.selectBodyView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.selectBodyView)
        
        NSLayoutConstraint.activate([
            self.selectBodyView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.selectBodyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.selectBodyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.selectBodyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

}

extension SelectBodyViewController: ISelectBodyViewController {
    
    func setCarBrand(index: Int) {
        self.presenter.setCarBrand(index: index)
    }
    
}
