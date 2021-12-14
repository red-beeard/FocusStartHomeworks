//
//  DownloadTaskInfo.swift
//  DownloadImage
//
//  Created by Red Beard on 13.12.2021.
//

import Foundation

final class DownloadTaskInfo {
    
    let name: String
    let downloadTask: URLSessionDownloadTask
    
    var url: URL?
    
    var totalBytesWritten: Int64?
    var totalBytesExpectedToWrite: Int64?
    var progress: Float = 0
    var isDownload = true
    var downloadIsOver: Bool {
        totalBytesWritten == totalBytesExpectedToWrite
    }
    
    init(name: String, downloadTask: URLSessionDownloadTask) {
        self.name = name
        self.downloadTask = downloadTask
    }
}
