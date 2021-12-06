//
//  CollectionAssembly.swift
//  CollectionAppWithArchitecture
//
//  Created by Red Beard on 28.11.2021.
//

import UIKit

final class CollectionAssembly {
    
    static func build() -> UIViewController {
        let model = ImageModel.shared
        let controller = CollectionViewController(model: model)
        return controller
    }
    
}
