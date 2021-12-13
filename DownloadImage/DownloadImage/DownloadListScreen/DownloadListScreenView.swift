//
//  DownloadListScreenView.swift
//  DownloadImage
//
//  Created by Red Beard on 12.12.2021.
//

import UIKit

protocol IDownloadListScreenView: UIView {
    
}

final class DownloadListScreenView: UIView {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuireView()
        self.configuireLayout()
    }
    
    private func configuireView() {
        self.backgroundColor = .systemBackground
        self.configuireCollectionView()
    }
    
    private func configuireCollectionView() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.register(DownloadCell.self, forCellWithReuseIdentifier: DownloadCell.identifier)
    }
    
    private func configuireLayout() {
        self.configuireCollectionViewLayout()
    }
    
    private func configuireCollectionViewLayout() {
        self.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension DownloadListScreenView: IDownloadListScreenView {
    
}
