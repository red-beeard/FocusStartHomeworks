//
//  SelectBodyPresenter.swift
//  CarAppMobile
//
//  Created by Red Beard on 07.12.2021.
//

import Foundation

protocol ISelectBodyPresenter {
    func loadView(controller: ISelectBodyViewController, view: ISelectBodyView)
}

final class SelectBodyPresenter {
    
    private let model: ICarModel
    private let router: ISelectBodyRouter
    
    private var controller: ISelectBodyViewController?
    private var view: ISelectBodyView?
    
    init(model: ICarModel, router: ISelectBodyRouter) {
        self.model = model
        self.router = router
    }
    
}

extension SelectBodyPresenter: ISelectBodyPresenter {
    
    func loadView(controller: ISelectBodyViewController, view: ISelectBodyView) {
        self.controller = controller
        self.view = view
    }
    
}
