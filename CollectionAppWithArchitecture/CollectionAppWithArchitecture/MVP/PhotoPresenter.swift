//
//  PhotoPresenter.swift
//  CollectionAppWithArchitecture
//
//  Created by Red Beard on 27.11.2021.
//

import Foundation

final class PhotoPresenter {
    
    private let id: UUID
    
    private let model: ImageModel
    private var view: PhotoView?
    private var controller: PhotoViewController?
    
    
    init(model: ImageModel, id: UUID) {
        self.model = model
        self.id = id
    }
    
    func loadView(controller: PhotoViewController, view: PhotoView) {
        self.controller = controller
        self.view = view
        
        guard let image = model.getImage(with: self.id) else { return }
        self.view?.setImageData(image: image)
    }
    
}
