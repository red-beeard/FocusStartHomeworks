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
