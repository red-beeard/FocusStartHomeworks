//
//  DownloadListScreenView.swift
//  DownloadImage
//
//  Created by Red Beard on 12.12.2021.
//

import UIKit

protocol IDownloadListScreenView: UIView {
    var searchHandler: ((String) -> Void)? { get set }
    
    func applyNewDownloadInfo(downloadInfoList: [DownloadInfo], animatingDifferences: Bool)
}

final class DownloadListScreenView: UIView {
    
    private enum Metrics {
        static let searchTFHeight = CGFloat(35)
        static let verticalSpacing = CGFloat(10)
        static let cellHeight = CGFloat(75)
    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Int, DownloadInfo>?
    private let searchTextField = UISearchTextField()
    
    var searchHandler: ((String) -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuireView()
        self.configuireLayout()
        self.addTapGestureToHideKeyboard()
    }
    
    private func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        addGestureRecognizer(tapGesture)
    }
    
}

// MARK: IDownloadListScreenView
extension DownloadListScreenView {
    
    private func configuireView() {
        self.backgroundColor = .systemBackground
        self.configuireSearchTextField()
        self.configuireCollectionView()
    }
    
    private func configuireCollectionView() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.register(DownloadCell.self, forCellWithReuseIdentifier: DownloadCell.identifier)
        
        self.dataSource = self.makeDataSource()
        self.collectionView.dataSource = self.dataSource
        self.collectionView.delegate = self
    }
    
    private func configuireSearchTextField() {
        self.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        self.searchTextField.placeholder = "Введите URL"
        self.searchTextField.returnKeyType = .done
        self.searchTextField.delegate = self
    }
    
}

// MARK: DownloadListScreenView + Configuire layout
extension DownloadListScreenView {
    
    private func configuireLayout() {
        self.configuireSearchTextFieldLayout()
        self.configuireCollectionViewLayout()
    }
    
    private func configuireSearchTextFieldLayout() {
        self.addSubview(self.searchTextField)
        
        NSLayoutConstraint.activate([
            self.searchTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.searchTextField.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.searchTextField.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.searchTextField.heightAnchor.constraint(equalToConstant: Metrics.searchTFHeight),
        ])
    }
    
    private func configuireCollectionViewLayout() {
        self.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: Metrics.verticalSpacing),
            self.collectionView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

// MARK: IDownloadListScreenView
extension DownloadListScreenView: IDownloadListScreenView {
    
    func applyNewDownloadInfo(downloadInfoList: [DownloadInfo], animatingDifferences: Bool) {
        self.applySnapshot(downloadInfoList: downloadInfoList, animatingDifferences: animatingDifferences)
    }
    
    
    
}

// MARK: UITextFieldDelegate
extension DownloadListScreenView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let _ = textField.text {
            self.endEditing(true)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        self.searchHandler?(text)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension DownloadListScreenView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = Metrics.cellHeight
        let width = collectionView.bounds.width
        return CGSize(width: width, height: height)
    }
    
}

// MARK: Work with diffableDataSource
extension DownloadListScreenView {
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Int, DownloadInfo> {
        let dataSource = UICollectionViewDiffableDataSource<Int, DownloadInfo>(collectionView: self.collectionView) { collectionView, indexPath, downloadInfo in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DownloadCell.identifier, for: indexPath) as? IDownloadCell
            
            cell?.setFilename(downloadInfo.name)
            cell?.setProgressLabel(downloadInfo.progressString)
            cell?.setProgress(downloadInfo.progress)
            cell?.setDownloadIsOver(downloadInfo.downloadIsOver)
            cell?.setImage(downloadInfo.url)
            return cell
        }
        
        return dataSource
    }
    
    private func applySnapshot(downloadInfoList: [DownloadInfo], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, DownloadInfo>()
        snapshot.appendSections([.zero])
        snapshot.appendItems(downloadInfoList)
        self.dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
}
