//
//  Concert.swift
//  myCV
//
//  Created by Red Beard on 15.11.2021.
//

struct Concert {
    let artist: String
    let year: Int
    let city: String
    
    var nameImage: String {
        "\(artist) - \(city) (\(year))"
    }
    
    var info: String {
        "\(city), \(year)"
    }
    
    static func getConcerts() -> [Concert] {
        [
            Concert(artist: "Макс Корж", year: 2018, city: "Ростов-на-Дону"),
            Concert(artist: "Макс Корж", year: 2019, city: "Пенза"),
            Concert(artist: "ATL", year: 2017, city: "Ростов-на-Дону"),
            Concert(artist: "Loqiemean", year: 2018, city: "Ростов-на-Дону")
        ]
    }
    
}
