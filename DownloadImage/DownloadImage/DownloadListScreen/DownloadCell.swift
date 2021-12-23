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
    
    func setProgress(_ value: Float)
    
    func setDownloadIsOver(_ value: Bool)
    
    func setProgressLabel(_ string: String)
    
    func setImage(_ url: URL?)
    
}

final class DownloadCell: UICollectionViewCell {
    
    private enum Metrics {
        static let spacing = CGFloat(10)
        static let stackViewSpacing = CGFloat(5)
        static let cornerRadius = CGFloat(10)
        
        static let progressLabelFontSize = CGFloat(12)
        
        static let photoImage = UIImage(systemName: "photo")
    }
    
    static let identifier = "DownloadCell"
    
    private let imageView = UIImageView()
    private let filenameLabel = UILabel()
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let progressLabel = UILabel()
    
    private var downloadIsOver: Bool?
    
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
        
        self.configuireImageView()
        self.configuireFilenameLabel()
        self.configuireProgressView()
        self.configuireProgressLabel()
    }
    
    private func configuireImageView() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.layer.cornerRadius = Metrics.cornerRadius
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.image = Metrics.photoImage
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
        self.configuireImageViewLayout()
        self.configuireStackViewLayout()
    }
    
    private func configuireImageViewLayout() {
        self.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.spacing),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.spacing),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.spacing),
            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor),
        ])
    }
    
    private func configuireStackViewLayout() {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.addArrangedSubview(self.filenameLabel)
        vStack.addArrangedSubview(self.progressView)
        vStack.addArrangedSubview(self.progressLabel)
        vStack.spacing = Metrics.stackViewSpacing
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.alignment = .fill
        
        self.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: Metrics.spacing),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.spacing),
        ])
    }
    
    private func downloadIsOverHandler() {
        self.progressView.isHidden = true
    }
    
}

extension DownloadCell: IDownloadCell {
    
    func setFilename(_ string: String) {
        self.filenameLabel.text = string
    }
    
    func setProgress(_ value: Float) {
        self.progressView.setProgress(value, animated: true)
    }
    
    func setDownloadIsOver(_ value: Bool) {
        self.downloadIsOver = value
        if value == true {
            self.downloadIsOverHandler()
        }
    }
    
    func setProgressLabel(_ string: String) {
        self.progressLabel.text = string
    }
    
    func setImage(_ url: URL?) {
        guard let url = url, let data = try? Data(contentsOf: url) else {
            return
        }

        self.imageView.image = UIImage(data: data)
    }
    
}
