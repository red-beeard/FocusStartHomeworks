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
    private let images: [Image]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(model: ImageModel) {
        self.customView = CollectionView(frame: .zero)
        self.model = model
        self.images = model.getImages()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.customView.loadView(controller: self)
        self.customView.setDelegate(delegate: self, dataSource: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Фотографии"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.configuireCustomView()
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

// MARK: - UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        
        cell.image = self.images[indexPath.item]
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = self.images[indexPath.item].id
        let photoVC = PhotoAssembly.build(id: id)
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
    
}




