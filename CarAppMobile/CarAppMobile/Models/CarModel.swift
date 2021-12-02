//
//  CarModel.swift
//  CarAppMobile
//
//  Created by Red Beard on 02.12.2021.
//

import Foundation

final class CarModel {
    
    static let shared = CarModel()
    
    private let cars: [Car]
    
    private init() {
        var cars = [Car]()
        
        for brand in CarBrand.allCases {
            for body in CarBody.allCases {
                let cost = Int.random(in: 20000...100000)
                let car = Car(brand: brand, body: body, cost: cost)
                cars.append(car)
            }
        }
        
        self.cars = cars
    }
    
    func getBrands() -> [CarBrand] {
        return CarBrand.allCases
    }
    
    func getBodys() -> [CarBody] {
        return CarBody.allCases
    }
    
    func getCost(brand: CarBrand, body: CarBody) -> Int? {
        return self.cars.first { $0.brand == brand && $0.body == body }?.cost
    }
    
}
