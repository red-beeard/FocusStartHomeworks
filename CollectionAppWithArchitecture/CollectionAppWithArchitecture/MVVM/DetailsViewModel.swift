//
//  DetailsViewModel.swift
//  CollectionAppWithArchitecture
//
//  Created by Red Beard on 29.11.2021.
//

import UIKit

final class Observable<T> {
    var data: T {
        didSet {
            self.notify?(self.data)
        }
    }
    
    private var notify: ((T) -> Void)?
    
    init(_ data: T) {
        self.data = data
    }
    
    func setNotify(notify: @escaping ((T) -> Void)) {
        self.notify = notify
        self.notify?(self.data)
    }
}

final class DetailsViewModel {
    private let model: ImageModel
    private let id: UUID
    
    var data: Observable<String> = Observable<String>("Нет данных")
    
    init(model: ImageModel, id: UUID) {
        self.model = model
        self.id = id
        self.updateModel()
    }
    
    func updateModel() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) { [weak self] in
            //            DispatchQueue.main.async { [weak self] in
            guard let id = self?.id else { return }
            guard let image = self?.model.getImage(with: id) else { return }
            
            if let uiImage = UIImage(named: image.filename),
               let ciImage = CIImage(image: uiImage)
            {
                let height = Int(ciImage.extent.height)
                let width = Int(ciImage.extent.width)
                let text = "\(height) x \(width)"
                self?.data.data = text
            }
            //            }
        }
    }
}


