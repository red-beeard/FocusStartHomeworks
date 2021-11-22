//
//  FlowLayout.swift
//  CollectionApp
//
//  Created by Red Beard on 18.11.2021.
//

import UIKit

final class FlowLayout: UICollectionViewFlowLayout {
    
    private enum Metrics {
        static let portraitNumberColumns = 2
        static let landscapeNumberColumns = 4
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        
        let screenSize = UIScreen.main.bounds
        let numColumns = (screenSize.width > screenSize.height)
                            ? Metrics.landscapeNumberColumns
                            : Metrics.portraitNumberColumns
        
        var availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        availableWidth -= CGFloat(numColumns + 1) * self.minimumInteritemSpacing
        
        let cellWidth = (availableWidth / CGFloat(numColumns)).rounded(.down)
        
        self.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.2)
        self.sectionInset = UIEdgeInsets(
            top: 2 * self.minimumInteritemSpacing,
            left: self.minimumInteritemSpacing,
            bottom: 0,
            right: self.minimumInteritemSpacing
        )
        self.sectionInsetReference = .fromLayoutMargins
    }
    
}
