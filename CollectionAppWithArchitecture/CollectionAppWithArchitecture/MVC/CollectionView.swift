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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuireView()
    }
    
    func loadView(controller: CollectionViewController) {
        self.controller = controller
    }
    
    func setDelegate(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
    }
    
    private func configuireView() {
        self.configuireCollectionView()
        self.configurationLayout()
    }
    
    private func configuireCollectionView() {
        let layout = FlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.showsVerticalScrollIndicator = false
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
