//
//  CollectionView.swift
//  CollectionAppWithArchitecture
//
//  Created by Red Beard on 26.11.2021.
//

import UIKit

final class CollectionView: UIView {

    private var collectionView: UICollectionView!
    
    private weak var controller: CollectionViewController!
    
    private var images: [Image]?
    
    func loadView(controller: CollectionViewController) {
        self.controller = controller
    }
    
    func setImages(images: [Image]?) {
        self.images = images
    }
    
    func configuireView() {
        configuireCollectionView()
        configurationLayout()
    }
    
    private func configuireCollectionView() {
        let layout = FlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    private func configurationLayout() {
        self.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}

// MARK: - UICollectionViewDataSource

extension CollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        
        if let image = self.images?[indexPath.item] {
            cell.image = image
        }
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension CollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let image = self.images?[indexPath.item] {
            self.controller.cellPressed(with: image)
        }
    }
    
}


