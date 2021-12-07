//
//  SelectBodyViewController.swift
//  CarAppMobile
//
//  Created by Red Beard on 07.12.2021.
//

import UIKit

protocol ISelectBodyViewController {
    
}

final class SelectBodyViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }

}
