//
//  Image.swift
//  CollectionApp
//
//  Created by Red Beard on 17.11.2021.
//

import Foundation

struct Image {
    let author: String
    let filename: String
    
    static func getImages() -> [Image] {
        DataManager.shared.images.map { (key, value) in
            Image(author: key, filename: value)
        }
    }
}
