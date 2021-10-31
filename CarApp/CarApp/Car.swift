//
//  Car.swift
//  CarApp
//
//  Created by Red Beard on 31.10.2021.
//

struct Car: CustomStringConvertible {
    
    let manufacturer: String
    let model: String
    let body: CarBody
    let yearOfIssue: Int?
    let carNumber: String?
    
    var description: String {
        var description = """
            Производитель: \(manufacturer)
            Модель: \(model)
            Тип кузова: \(body)
            Год выпуска: \(yearOfIssue?.description ?? "-")
        """
        
        if let carNumber = carNumber {
            description += "\n\tГос. номер: \(carNumber)"
        }
        
        return description
    }
}
