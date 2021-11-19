//
//  ConcertView.swift
//  myCV
//
//  Created by Red Beard on 15.11.2021.
//

import UIKit

final class ConcertView: UIView {
    
    private enum Metrics {
        static let artistLabelFontSize = CGFloat(25)
        
        static let mediumIndent = CGFloat(20)
        static let smallIndent = CGFloat(10)
    }

    private let imageView = UIImageView()
    private let artistLabel = UILabel()
    private let infoLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(concert: Concert) {
        self.init(frame: .zero)
        
        configuireView(with: concert)
        configuireLayout()
    }
    
    private func configuireView(with concert: Concert) {
        translatesAutoresizingMaskIntoConstraints = false
        
        configuireImageView(with: concert.nameImage)
        configuireArtistLabel(with: concert.artist)
        configuireInfoLabel(with: concert.info)
        configuireLayout()
    }
    
    private func configuireImageView(with nameImage: String) {
        let image = UIImage(named: nameImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = image
    }
    
    private func configuireArtistLabel(with nameArtist: String) {
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.text = nameArtist
        artistLabel.font = UIFont.boldSystemFont(ofSize: Metrics.artistLabelFontSize)
    }
    
    private func configuireInfoLabel(with info: String) {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = info
        infoLabel.textColor = .systemGray
    }
    
    private func configuireLayout() {
        let screenSize = UIScreen.main.bounds
        self.addSubview(imageView)
        self.addSubview(artistLabel)
        self.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: screenSize.width * 0.8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.mediumIndent),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Metrics.mediumIndent),
            artistLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: Metrics.smallIndent),
            infoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
