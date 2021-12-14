//
//  DownloadCell.swift
//  DownloadImage
//
//  Created by Red Beard on 12.12.2021.
//

import UIKit

protocol IDownloadCell: UICollectionViewCell {
    
    static var identifier: String { get }
    
    func setFilename(_ string: String)
    
    func setProgressLabel(_ string: String)
    
}

final class DownloadCell: UICollectionViewCell {
    
    private enum Metrics {
        static let spacing = CGFloat(10)
        static let stackViewSpacing = CGFloat(8)
        static let cornerRadius = CGFloat(10)
        
        static let progressLabelFontSize = CGFloat(12)
    }
    
    static let identifier = "DownloadCell"
    
    private let filenameLabel = UILabel()
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let progressLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuireView()
        self.configurationLayout()
    }
    
    private func configuireView() {
        self.layer.cornerRadius = Metrics.cornerRadius
        self.backgroundColor = .systemFill
        
        self.configuireFilenameLabel()
        self.configuireProgressView()
        self.configuireProgressLabel()
    }
    
    private func configuireFilenameLabel() {
        self.filenameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.filenameLabel.textAlignment = .left
        self.filenameLabel.text = "text"
    }
    
    private func configuireProgressView() {
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        self.progressView.progress = 0
    }
    
    private func configuireProgressLabel() {
        self.progressLabel.translatesAutoresizingMaskIntoConstraints = false
        self.progressLabel.textAlignment = .left
        self.progressLabel.textColor = .systemGray
        self.progressLabel.font = UIFont.systemFont(ofSize: Metrics.progressLabelFontSize)
        self.progressLabel.text = "text"
    }
    
    private func configurationLayout() {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.addArrangedSubview(self.filenameLabel)
        vStack.addArrangedSubview(self.progressView)
        vStack.addArrangedSubview(self.progressLabel)
        vStack.spacing = Metrics.stackViewSpacing
        vStack.axis = .vertical
        vStack.alignment = .fill
        
        self.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.spacing),
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.spacing),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.spacing),
            vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.spacing)
        ])
    }
    
}

extension DownloadCell: IDownloadCell {
    
    func setFilename(_ string: String) {
        self.filenameLabel.text = string
    }
    
    func setProgressLabel(_ string: String) {
        self.progressLabel.text = string
    }
    
}
