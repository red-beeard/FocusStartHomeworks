//
//  ViewController.swift
//  DownloadImage
//
//  Created by Red Beard on 12.12.2021.
//

import UIKit

protocol IDownloadListViewController: UIViewController {
    
}

final class DownloadListViewController: UIViewController {
    
    private let searchController = UISearchController()
    private let screenView: IDownloadListScreenView = DownloadListScreenView(frame: .zero)
    
    private let presenter: IDownloadListPresenter
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: IDownloadListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, view: self.screenView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuire()
    }
    
    private func configuire() {
        self.view.backgroundColor = .systemBackground
        self.title = "Загрузки"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.configureSearchController()
        self.configuireLayout()
    }
    
    private func configureSearchController() {
        self.searchController.searchBar.placeholder = "Введите URL"
        self.navigationItem.searchController = self.searchController
    }
    
    private func configuireLayout() {
        self.view.addSubview(self.screenView)
        
        NSLayoutConstraint.activate([
            self.screenView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.screenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.screenView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.screenView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }

}

extension DownloadListViewController: IDownloadListViewController {
    
}
