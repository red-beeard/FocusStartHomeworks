//
//  Command.swift
//  CarApp
//
//  Created by Red Beard on 31.10.2021.
//

enum Command: Int, CaseIterable, CustomStringConvertible {
    case add = 1
    case show
    case showFilter
    case exit = 0
    
    var description: String {
        switch self {
        case .add:
            return "Добавление нового автомобиля"
        case .show:
            return "Вывод списка добавленных автомобилей"
        case .showFilter:
            return "Вывод списка автомобилей с использованием фильтра по типу кузова"
        case .exit:
            return "Выход"
        }
    }

}
