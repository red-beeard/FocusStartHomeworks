//
//  PhotoPresenter.swift
//  CollectionAppWithArchitecture
//
//  Created by Red Beard on 27.11.2021.
//

import Foundation

final class PhotoPresenter {
    
    private weak var view: PhotoView?
    private weak var controller: PhotoViewController?
    
    private let id: UUID
    private let model: ImageModel
    
    init(model: ImageModel, id: UUID) {
        self.model = model
        self.id = id
    }
    
    func loadView(controller: PhotoViewController, view: PhotoView) {
        self.controller = controller
        self.view = view
        
        guard let image = self.model.getImage(with: self.id) else { return }
        self.view?.setImageData(image: image)
        
        self.setHandlers()
    }
    
    private func detailsButtonOnTouched() {
        self.controller?.present(DetailsAssembly.build(id: self.id), animated: true)
    }
    
    private func setHandlers() {
        self.view?.detailsButtonOnTouched = { [weak self] in
            self?.detailsButtonOnTouched()
        }
    }
    
}
