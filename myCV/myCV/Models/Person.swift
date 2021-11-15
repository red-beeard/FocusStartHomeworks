//
//  Person.swift
//  myCV
//
//  Created by Red Beard on 13.11.2021.
//

struct Person {
    let name: String
    let surname: String
    let avatar: String
    let aboutMe: String
    let skills: [Skill]
    let concerts: [Concert]
    
    static func getPerson() -> Person {
        Person(
            name: "Александр",
            surname: "Нифонтов",
            avatar: "avatar.jpeg",
            aboutMe: """
                    Мне 22 года, и ещё недавно был в Санкт-Петербурге, но сейчас живу в Ростове-на-Дону, который является моим родным городом.
                    
                    Окончил бакалавриат по направлению "Прикладная математика и информатика". Надеюсь в ЦФТ получить прикладные знания для работы и саму работу))
                    """,
            skills: Skill.getSkills(),
            concerts: Concert.getConcerts()
        )
    }
    
}

struct Skill {
    let language: String
    let description: String
    
    static func getSkills() -> [Skill] {
        [
            Skill(language: "Swift", description: "Изучаю для работы"),
            Skill(language: "Python", description: "Учил в рамках универа")
        ]
    }
}

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
