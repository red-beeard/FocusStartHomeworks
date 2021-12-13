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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = DownloadListScreenView()
        
        self.title = "Загрузки"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension DownloadListViewController: IDownloadListViewController {
    
}
