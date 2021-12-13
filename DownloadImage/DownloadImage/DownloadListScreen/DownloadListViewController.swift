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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = DownloadListScreenView()
        self.configuire()
    }
    
    private func configuire() {
        self.title = "Загрузки"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.configureSearchController()
    }
    
    private func configureSearchController() {
        self.searchController.searchBar.placeholder = "Введите URL"
        self.navigationItem.searchController = self.searchController
    }

}

extension DownloadListViewController: IDownloadListViewController {
    
}
