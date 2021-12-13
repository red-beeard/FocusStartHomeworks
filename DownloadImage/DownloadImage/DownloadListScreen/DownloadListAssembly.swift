//
//  DownloadListAssembly.swift
//  DownloadImage
//
//  Created by Red Beard on 12.12.2021.
//

final class DownloadListAssembly {
    
    static func build() -> IDownloadListViewController {
        let networkService = NetworkService()
        let presenter = DownloadListPresenter(service: networkService)
        
        return DownloadListViewController(presenter: presenter)
    }
    
}
