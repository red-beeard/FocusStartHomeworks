//
//  PhotoAssembly.swift
//  CollectionAppWithArchitecture
//
//  Created by Red Beard on 28.11.2021.
//

import UIKit

final class PhotoAssembly {
    
    static func build(id: UUID) -> UIViewController {
        let model = ImageModel.shared
        let presenter = PhotoPresenter(model: model, id: id)
        let controller = PhotoViewController(presenter: presenter)
        
        return controller
    }
    
}
