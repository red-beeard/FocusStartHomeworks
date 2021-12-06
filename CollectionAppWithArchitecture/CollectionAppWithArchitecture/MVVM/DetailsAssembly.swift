//
//  DetailsAssembly.swift
//  CollectionAppWithArchitecture
//
//  Created by Red Beard on 29.11.2021.
//

import UIKit

final class DetailsAssembly {
    
    static func build(id: UUID) -> UIViewController {
        let model = ImageModel.shared
        let viewModel = DetailsViewModel(model: model, id: id)
        let detailsVC = DetailsViewController(viewModel: viewModel)
        let controller = UINavigationController(rootViewController: detailsVC)
        
        return controller
    }
    
}
