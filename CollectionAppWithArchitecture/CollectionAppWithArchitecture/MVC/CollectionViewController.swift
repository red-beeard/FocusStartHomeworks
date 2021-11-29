//
//  ViewController.swift
//  CollectionAppWithArchitecture
//
//  Created by Red Beard on 26.11.2021.
//

import UIKit

final class CollectionViewController: UIViewController {
    
    private let customView: CollectionView
    
    private let model: ImageModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(model: ImageModel) {
        self.customView = CollectionView(frame: .zero)
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.customView.loadView(controller: self)
        self.customView.setImages(images: model.getImages())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Фотографии"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.configuireCustomView()
    }
    
    func cellPressed(with id: UUID) {
        let photoVC = PhotoAssembly.build(id: id)
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
    
    private func configuireCustomView() {
        self.view.addSubview(self.customView)
        self.customView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.customView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.customView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.customView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.customView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
}

