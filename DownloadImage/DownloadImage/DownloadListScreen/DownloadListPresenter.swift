//
//  DownloadListPresenter.swift
//  DownloadImage
//
//  Created by Red Beard on 13.12.2021.
//

import Foundation

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
        
        self.networkService.completionFailure = { [weak self] error in
            print("[NETWORK] error is: \(error)")
            DispatchQueue.main.async {
                self?.controller?.showAlert(title: "Ошибка😔", message: error.localizedDescription)
            }
        }
        
        self.networkService.completionDownloadTaskInfoUpdate = { [weak self] downloadsList, changeCount in
            let downloads = downloadsList.map { taskInfo -> DownloadInfo in
                let totalMegaBytesWritten = Float(taskInfo.totalBytesWritten ?? 0) / 1024 / 1024
                let totalMegaBytesExpectedToWrite = Float(taskInfo.totalBytesExpectedToWrite ?? 0) / 1024 / 1024
                let progressString = String(format: "%.2f МБ из %.2f МБ", totalMegaBytesWritten, totalMegaBytesExpectedToWrite)
                
                return DownloadInfo(id: taskInfo.id,
                                    name: taskInfo.name,
                                    url: taskInfo.url,
                                    progressString: progressString,
                                    progress: taskInfo.progress,
                                    downloadIsOver: taskInfo.downloadIsOver)
            }
            DispatchQueue.main.async {
                self?.view?.applyNewDownloadInfo(downloadInfoList: downloads, animatingDifferences: changeCount)
            }
        }
    }
    
    private func searchURL(_ string: String) {
        self.networkService.loadImageFrom(url: string)
    }
    
}

extension DownloadListPresenter: IDownloadListPresenter {
    
    func loadView(controller: IDownloadListViewController, view: IDownloadListScreenView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
    
}
