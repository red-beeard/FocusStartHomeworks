//
//  DownloadInfo.swift
//  DownloadImage
//
//  Created by Red Beard on 14.12.2021.
//

import Foundation

struct DownloadInfo {
    let id: UUID
    let name: String
    var url: URL?
    
    var progressString: String = "Нет данных"
    var progress: Float = 0
    var downloadIsOver: Bool
}

extension DownloadInfo: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
}
