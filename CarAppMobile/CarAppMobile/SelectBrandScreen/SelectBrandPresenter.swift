//
//  SelectCarPresenter.swift
//  CarAppMobile
//
//  Created by Red Beard on 03.12.2021.
//

import Foundation
import UIKit

protocol ISelectBrandPresenter {
    func loadView(controller: ISelectBrandViewController, view: ISelectBrandView)
}

final class SelectBrandPresenter {
    
    private let model: ICarModel
    private var controller: ISelectBrandViewController?
    private var view: ISelectBrandView?
    
    init(model: ICarModel) {
        self.model = model
    }
    
}

extension SelectBrandPresenter: ISelectBrandPresenter {
    
    func loadView(controller: ISelectBrandViewController, view: ISelectBrandView) {
        self.controller = controller
        self.view = view
    }
    
}
