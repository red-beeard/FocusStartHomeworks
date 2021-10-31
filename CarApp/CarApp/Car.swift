//
//  Car.swift
//  CarApp
//
//  Created by Red Beard on 31.10.2021.
//

struct Car {
    
    enum Body: String {
        case hatchback = "Хэтчбек"
        case sedan = "Седан"
        case cabriolet = "Кабриолет"
        case roadster = "Родстер"
        case unknown = "Неизвестный"
    }
    
    let manufacturer: String
    let model: String
    let body: Body
    let yearOfIssue: Int?
    let carNumber: String?
    
    var description: String {
        var description = "Производитель: \(manufacturer)\n" +
        "Модель: \(model)\n" +
        "Тип кузова: \(body)\n" +
        "Год выпуска: \(yearOfIssue?.description ?? "-")\n"
        
        if let carNumber = carNumber {
            description += "Гос. номер: \(carNumber)"
        }
        
        return description
    }
}
