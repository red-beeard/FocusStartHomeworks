//
//  ViewController.swift
//  DownloadImage
//
//  Created by Red Beard on 12.12.2021.
//

import UIKit

protocol IDownloadListViewController: UIViewController {
    func showAlert(title: String?, message: String?)
}

final class DownloadListViewController: UIViewController {
    
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
        
        self.configuireScreenView()
    }
    
    private func configuireScreenView() {
        self.screenView.translatesAutoresizingMaskIntoConstraints = false
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
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionOk = UIAlertAction(title: "Ок", style: .default) { action in
            self.dismiss(animated: true)
        }
        alertController.addAction(actionOk)
        
        self.present(alertController, animated: true)
    }
    
}
