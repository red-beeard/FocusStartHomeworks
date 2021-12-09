//
//  SelectBodyPresenter.swift
//  CarAppMobile
//
//  Created by Red Beard on 07.12.2021.
//

import Foundation

protocol ISelectBodyPresenter {
    func loadView(controller: ISelectBodyViewController, view: ISelectBodyView)
    func setCarBrand(index: Int)
}

final class SelectBodyPresenter {
    
    private let model: ICarModel
    private let router: ISelectBodyRouter
    private var carBrandIndex: Int?
    private weak var controller: ISelectBodyViewController?
    private weak var view: ISelectBodyView?
    
    init(model: ICarModel, router: ISelectBodyRouter) {
        self.model = model
        self.router = router
    }
    
    private func loadData() {
        self.view?.showActivityIndicator(true)
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: DispatchTime.now() + 5) {
            let carBodys = self.model.getBodys()
            
            DispatchQueue.main.async {
                self.setDataToTableView(numberOfRowsInSection: carBodys.count,
                                        strings: carBodys.map { $0.rawValue })
                self.changeCostLabel(indexBody: .zero)
                self.changeImageView(indexBody: .zero)
                self.view?.showActivityIndicator(false)
            }
            
        }
    }
    
    private func setDataToTableView(numberOfRowsInSection: Int, strings: [String]) {
        self.view?.setNumberOfRowsInSection(numberOfRowsInSection)
        self.view?.setTextInCells(strings)
        self.view?.setChecked(for: .zero)
    }
    
    private func setHandlers() {
        self.view?.changeBodyHandler = { [weak self] index in
            self?.changeCarBody(to: index)
        }
        
        self.view?.calculateCostHandler = { [weak self] index in
            self?.showCostInLabel(to: index)
        }
    }
    
    private func changeCarBody(to index: Int) {
        self.changeImageView(indexBody: index)
    }
    
    private func showCostInLabel(to index: Int) {
        self.changeCostLabel(indexBody: index)
    }
    
    private func changeCostLabel(indexBody: Int) {
        guard let carBrandIndex = self.carBrandIndex else { return }
        let car = self.model.getCar(for: carBrandIndex, and: indexBody)
        if let car = car {
            self.view?.setTextInCostLabel("\(car.cost)$")
        }
    }
    
    private func changeImageView(indexBody: Int) {
        guard let carBrandIndex = self.carBrandIndex else { return }
        let car = self.model.getCar(for: carBrandIndex, and: indexBody)
        if let car = car {
            self.view?.setImage(name: car.filename)
        }
    }
    
}

extension SelectBodyPresenter: ISelectBodyPresenter {
    
    func setCarBrand(index: Int) {
        self.carBrandIndex = index
        self.loadData()
    }
    
    func loadView(controller: ISelectBodyViewController, view: ISelectBodyView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
    
}
