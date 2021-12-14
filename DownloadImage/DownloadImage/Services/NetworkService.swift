//
//  NetworkService.swift
//  DownloadImage
//
//  Created by Red Beard on 13.12.2021.
//

import Foundation

protocol INetworkService: AnyObject {
    
    var completionFailure: ((Error) -> Void)? { get set }
    var completionDownloadTaskInfoUpdate: (([DownloadTaskInfo]) -> Void)? { get set }
    
    func loadImageFrom(url: String)
    
}

final class NetworkService: NSObject {
    
    private lazy var session = URLSession(configuration: .default,
                                          delegate: self,
                                          delegateQueue: nil)
    
    private var downloadTaskInfoList = [DownloadTaskInfo]()
    var completionFailure: ((Error) -> Void)?
    var completionDownloadTaskInfoUpdate: (([DownloadTaskInfo]) -> Void)?
    
    private func addDownloadTaskInfo(name: String, task: URLSessionDownloadTask) {
        let downloadTaskInfo = DownloadTaskInfo(name: name, downloadTask: task)
        self.downloadTaskInfoList.append(downloadTaskInfo)
        self.completionDownloadTaskInfoUpdate?(self.downloadTaskInfoList)
    }
    
}

extension NetworkService: INetworkService {
    
    func loadImageFrom(url: String) {
        guard let url = URL(string: url) else {
            self.completionFailure?(NetworkError.badURL)
            return
        }
        
        let downloadTask = self.session.downloadTask(with: url)
        self.addDownloadTaskInfo(name: url.lastPathComponent, task: downloadTask)
        downloadTask.resume()
    }
    
}

extension NetworkService: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let downloadTaskInfo = self.downloadTaskInfoList.first { downloadTask === $0.downloadTask }
        downloadTaskInfo?.isDownload = false
        
        do {
            let documentsURL = try FileManager.default.url(for: .documentDirectory,
                                                              in: .userDomainMask,
                                                              appropriateFor: nil,
                                                              create: false)
            let savedURL = documentsURL.appendingPathComponent(location.lastPathComponent)
            try FileManager.default.moveItem(at: location, to: savedURL)
            
            downloadTaskInfo?.url = savedURL
        } catch {
            self.downloadTaskInfoList.removeAll { downloadTask === $0.downloadTask }
            self.completionFailure?(error)
        }
        self.completionDownloadTaskInfoUpdate?(self.downloadTaskInfoList)
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let downloadTaskInfo = self.downloadTaskInfoList.first { downloadTask === $0.downloadTask }
        
        downloadTaskInfo?.totalBytesWritten = totalBytesWritten
        downloadTaskInfo?.totalBytesExpectedToWrite = totalBytesExpectedToWrite
        downloadTaskInfo?.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        self.completionDownloadTaskInfoUpdate?(self.downloadTaskInfoList)
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        if let error = error {
            self.completionFailure?(error)
        } else {
            print("[NETWORK]: \(#function) - error равно nil")
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        self.downloadTaskInfoList.removeAll { task === $0.downloadTask }
        self.completionDownloadTaskInfoUpdate?(self.downloadTaskInfoList)
        
        if let error = error {
            self.completionFailure?(error)
        } else {
            print("[NETWORK]: \(#function) - error равно nil")
        }
    }
    
}
