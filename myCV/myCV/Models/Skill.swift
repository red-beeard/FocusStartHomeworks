//
//  Skill.swift
//  myCV
//
//  Created by Red Beard on 15.11.2021.
//

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
