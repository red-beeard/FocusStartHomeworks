//
//  SelectBrandViewController.swift
//  CarAppMobile
//
//  Created by Red Beard on 03.12.2021.
//

import UIKit

protocol ISelectBrandViewController: UIViewController {
    
}

final class SelectBrandViewController: UIViewController {
    
    private let presenter: ISelectBrandPresenter
    private let selectBrandView: ISelectBrandView
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: ISelectBrandPresenter) {
        self.presenter = presenter
        self.selectBrandView = SelectBrandView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        presenter.loadView(controller: self, view: self.selectBrandView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.configuireView()
    }
    
    private func configuireView() {
        self.selectBrandView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(selectBrandView)
        
        NSLayoutConstraint.activate([
            self.selectBrandView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.selectBrandView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.selectBrandView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.selectBrandView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

}

extension SelectBrandViewController: ISelectBrandViewController {
    
}
