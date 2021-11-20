//
//  ViewController.swift
//  CollectionApp
//
//  Created by Red Beard on 16.11.2021.
//

import UIKit

class CollectionViewController: UIViewController {
    
    private enum Constants {
        static let sectionHeader = "section-header-element-kind"
    }
    
    private enum Metrics {
        static let smallIndent = CGFloat(5)
    }
    
    private let images = Image.getImages()
    private var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Фотографии"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .systemBackground
        
        self.configuireCollectionView()
        self.configurationLayout()
        self.configureDataSource()
    }
    
    private func configuireCollectionView() {
//        let layout = FlowLayout()
        let layout = self.createCompositionalLayout()
        
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        self.collectionView.showsVerticalScrollIndicator = false
        
        self.collectionView.delegate = self
    }
    
    private func configurationLayout() {
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        ))
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        ))
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.33)),
            subitems: [leadingItem, trailingItem, trailingItem])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<PhotoCell, Int> { cell, indexPath, itemIdentifier in
            cell.image = self.images[itemIdentifier]
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: self.collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Int) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
//            cell.image = self.images[indexPath.item]
            return cell
            }
        
//        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: Constants.sectionHeader) { supplementaryView, elementKind, indexPath in
//            supplementaryView.label.text = "\(indexPath.section)st section"
//        }
//
//        dataSource.supplementaryViewProvider = { (view, kind, index) in
//            return self.collectionView.dequeueConfiguredReusableSupplementary(
//                using: supplementaryRegistration, for: index)
//        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems(Array(0 ..< self.images.count))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

// MARK: - UICollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoVC = PhotoViewController()
        photoVC.image = self.images[indexPath.item]
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
    
}

