//
//  DownloadListPresenter.swift
//  DownloadImage
//
//  Created by Red Beard on 13.12.2021.
//

protocol IDownloadListPresenter {
    func loadView(controller: IDownloadListViewController, view: IDownloadListScreenView)
}

final class DownloadListPresenter {
    
    private let networkService: INetworkService
    private weak var controller: IDownloadListViewController?
    private weak var view: IDownloadListScreenView?
    
    init(service: NetworkService) {
        self.networkService = service
    }
    
    private func setHandlers() {
        self.view?.searchHandler = { [weak self] string in
            self?.searchURL(string)
        }
    }
    
    private func searchURL(_ string: String) {
        print(string)
    }
    
}

extension DownloadListPresenter: IDownloadListPresenter {
    
    func loadView(controller: IDownloadListViewController, view: IDownloadListScreenView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
    
}
