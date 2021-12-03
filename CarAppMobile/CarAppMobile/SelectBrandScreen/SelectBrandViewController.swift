//
//  SelectBrandViewController.swift
//  CarAppMobile
//
//  Created by Red Beard on 03.12.2021.
//

import UIKit

protocol ISelectBrandViewController {
    
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
        self.view.backgroundColor = .white
    }

}

extension SelectBrandViewController: ISelectBrandViewController {
    
}
