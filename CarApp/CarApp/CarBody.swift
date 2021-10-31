//
//  CarBody.swift
//  CarApp
//
//  Created by Red Beard on 31.10.2021.
//

enum CarBody: String, CaseIterable {
    case hatchback = "Хэтчбек"
    case sedan = "Седан"
    case cabriolet = "Кабриолет"
    case roadster = "Родстер"
    case unknown = "Неизвестный"
    
    init(index: Int) {
        for (indexBody, body) in CarBody.allCases.enumerated() {
            if indexBody == index {
                self = body
                return
            }
        }
        
        self = .unknown
    }
}
