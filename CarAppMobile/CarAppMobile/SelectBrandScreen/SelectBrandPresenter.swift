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
    private weak var controller: ISelectBrandViewController?
    private weak var view: ISelectBrandView?
    
    init(model: ICarModel) {
        self.model = model
    }
    
    private func setHandlers() {
        self.view?.getNumberOfRowsInSection = { [weak self] in
            self?.getNumberOfBrand() ?? 0
        }
        
        self.view?.getTextForCell = { [weak self] index in
            self?.getBrandName(index: index) ?? "No text"
        }
    }
    
    private func getNumberOfBrand() -> Int {
        return self.model.getBrands().count
    }
    
    private func getBrandName(index: Int) -> String {
        return self.model.getBrands()[index].rawValue
    }
    
}

extension SelectBrandPresenter: ISelectBrandPresenter {
    
    func loadView(controller: ISelectBrandViewController, view: ISelectBrandView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
    
}
