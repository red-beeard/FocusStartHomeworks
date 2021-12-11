//
//  SelectBodyPresenter.swift
//  CarAppMobile
//
//  Created by Red Beard on 07.12.2021.
//

import Foundation

protocol ISelectBodyPresenter {
    func loadView(controller: ISelectBodyViewController, view: ISelectBodyScreenView)
    func loadData()
    func setCarBrand(index: Int)
}

final class SelectBodyPresenter {
    
    private let model: ICarModel
    private var carBrandIndex: Int?
    private weak var controller: ISelectBodyViewController?
    private weak var view: ISelectBodyScreenView?
    
    init(model: ICarModel) {
        self.model = model
    }
    
    private func setDataToTableView(numberOfRowsInSection: Int, strings: [String]) {
        self.view?.setNumberOfRowsInSection(numberOfRowsInSection)
        self.view?.setTextInCells(strings)
        self.view?.setChecked(for: .zero)
    }
    
    private func setHandlers() {
        self.view?.setChangeBodyHandler { [weak self] index in
            self?.changeCarBody(to: index)
        }
        
        self.view?.calculateCostHandler = { [weak self] index in
            self?.showCostInLabel(to: index)
        }
        
        self.controller?.backButtonTouchedHandler = { [weak self] in
            self?.controller?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func changeCarBody(to index: Int) {
        self.changeImageView(indexBody: index)
    }
    
    private func showCostInLabel(to index: Int) {
        self.changeCostLabel(indexBody: index)
    }
    
    private func getCarWith(indexBody: Int, comletion: ((Car) -> Void)) {
        guard let carBrandIndex = self.carBrandIndex else { return }
        let car = self.model.getCar(for: carBrandIndex, and: indexBody)
        if let car = car {
            comletion(car)
        }
    }
    
    private func changeCostLabel(indexBody: Int) {
        self.getCarWith(indexBody: indexBody) { car in
            self.view?.setTextInCostLabel("\(car.cost)$")
        }
    }
    
    private func changeImageView(indexBody: Int) {
        self.getCarWith(indexBody: indexBody) { car in
            self.view?.setImage(name: car.filename)
        }
    }
    
    private func showActivityIndicator(_ show: Bool) {
        self.controller?.showActivityIndicator(show)
        self.view?.setHideAllSubviews(show)
    }
    
}

extension SelectBodyPresenter: ISelectBodyPresenter {
    
    func setCarBrand(index: Int) {
        self.carBrandIndex = index
    }
    
    func loadView(controller: ISelectBodyViewController, view: ISelectBodyScreenView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
    
    func loadData() {
        self.showActivityIndicator(true)
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: DispatchTime.now() + 5) {
            let carBodys = self.model.getBodys()
            
            DispatchQueue.main.async {
                self.setDataToTableView(numberOfRowsInSection: carBodys.count,
                                        strings: carBodys.map { $0.rawValue })
                self.changeCostLabel(indexBody: .zero)
                self.changeImageView(indexBody: .zero)
                self.showActivityIndicator(false)
            }
        }
    }
    
}
