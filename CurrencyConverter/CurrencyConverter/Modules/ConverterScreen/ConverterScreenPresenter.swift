//
//  ConverterScreenPresenter.swift
//  CurrencyConverter
//
//  Created by Red Beard on 24.12.2021.
//

import Foundation

protocol IConverterScreenPresenter {
    func loadView(controller: IConverterScreenViewController, view: IConverterScreenView)
}

final class ConverterScreenPresenter: NSObject {
    
    private enum Constants {
        static let titleVC = "Converter"
    }
    
    private let dataManager: IDataManager
    private let router: IConverterScreenRouter
    
    private weak var controller: IConverterScreenViewController?
    private weak var view: IConverterScreenView?
    
    private var firstCurrency: CurrencyDTO?
    private var secondCurrency: CurrencyDTO?
    
    init(dataManager: IDataManager, router: IConverterScreenRouter) {
        self.dataManager = dataManager
        self.router = router
    }
    
    private func setHandlers() {
        self.view?.firstSelectCurrencyTappedHandler = { [weak self] in
            self?.router.goSelect(for: PositionCurrencies.first.rawValue)
        }
        
        self.view?.secondSelectCurrencyTappedHandler =  { [weak self] in
            self?.router.goSelect(for: PositionCurrencies.second.rawValue)
        }
        
        self.view?.firstCurrencyValueChanged = { [weak self] value in
            self?.updateConverterValue(value, PositionCurrencies.first)
        }
        
        self.view?.secondCurrencyValueChanged = { [weak self] value in
            self?.updateConverterValue(value, PositionCurrencies.second)
        }
    }
    
    private func addObservers() {
        UserDefaults.standard.addObserver(self, forKeyPath: PositionCurrencies.first.rawValue, options: .new, context: nil)
        UserDefaults.standard.addObserver(self, forKeyPath: PositionCurrencies.second.rawValue, options: .new, context: nil)
    }
    
    private func setCurrencies() {
        let firstCurrencyData = UserDefaults.standard.data(forKey: PositionCurrencies.first.rawValue)
        let secondCurrencyData = UserDefaults.standard.data(forKey: PositionCurrencies.second.rawValue)
        
        if let firstCurrencyData = firstCurrencyData, let secondCurrencyData = secondCurrencyData {
            guard let firstCurrency = try? JSONDecoder().decode(CurrencyDTO.self, from: firstCurrencyData) else { return }
            self.firstCurrency = firstCurrency
            let firstCurrencyViewModel = ConverterCurrencyViewModel(firstCurrency)
            
            guard let secondCurrency = try? JSONDecoder().decode(CurrencyDTO.self, from: secondCurrencyData) else { return }
            self.secondCurrency = secondCurrency
            let secondCurrencyViewModel = ConverterCurrencyViewModel(secondCurrency)
            
            DispatchQueue.main.async {
                self.view?.updateFirstCurrencyView(viewModel: firstCurrencyViewModel)
                self.view?.updateSecondCurrencyView(viewModel: secondCurrencyViewModel)
            }
        }
    }
    
    private func updateConverterValue(_ value: String?, _ position: PositionCurrencies) {
        guard let value = value,
              let doubleValue = Double(value)
        else {
            self.view?.clearTextFields()
            return
        }
        
        guard let firstExchange = firstCurrency?.exchangeRate else {
            self.view?.updateSecondTextField(nil)
            return
        }
        guard let secondExchange = secondCurrency?.exchangeRate else {
            self.view?.updateFirstTextField(nil)
            return
        }
        
        switch position {
        case .first:
            let result = secondExchange * doubleValue / firstExchange
            let resultString = String(format: "%.8f", result)
            self.view?.updateSecondTextField(resultString)
        case .second:
            let result = firstExchange * doubleValue / secondExchange
            let resultString = String(format: "%.8f", result)
            self.view?.updateFirstTextField(resultString)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else { return }
        guard let currencyData = UserDefaults.standard.data(forKey: keyPath) else { return }
        guard let currency = try? JSONDecoder().decode(CurrencyDTO.self, from: currencyData) else { return }
        let currencyViewModel = ConverterCurrencyViewModel(currency)
        
        switch keyPath {
        case PositionCurrencies.first.rawValue:
            self.firstCurrency = currency
            DispatchQueue.main.async {
                self.view?.updateFirstCurrencyView(viewModel: currencyViewModel)
                self.view?.clearTextFields()
            }
        case PositionCurrencies.second.rawValue:
            self.secondCurrency = currency
            DispatchQueue.main.async {
                self.view?.updateSecondCurrencyView(viewModel: currencyViewModel)
                self.view?.clearTextFields()
            }
        default:
            return
        }
    }
    
}

extension ConverterScreenPresenter: IConverterScreenPresenter {
    
    func loadView(controller: IConverterScreenViewController, view: IConverterScreenView) {
        self.controller = controller
        self.controller?.setTitle(Constants.titleVC)
        
        self.view = view
        
        self.setHandlers()
        self.addObservers()
        self.setCurrencies()
    }
    
}
