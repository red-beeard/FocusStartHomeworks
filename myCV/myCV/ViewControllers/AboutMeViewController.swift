//
//  AboutMeViewController.swift
//  myCV
//
//  Created by Red Beard on 12.11.2021.
//

import UIKit

final class AboutMeViewController: UIViewController {
    
    private enum Metrics {
        static let smallIndent = CGFloat(10)
        static let mediumIndent = CGFloat(20)
        static let largeIndent = CGFloat(30)
        
        static let fullnameLabelFontSize = CGFloat(30)
    }
    
    var person: Person!
    
    private var avatarImageView: UIImageView!
    private var fullnameLabel: UILabel!
    private var aboutMeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuireAvatar()
        configuireFullnameLabel()
        configuireAboutMeLabel()
        configuireLayout()
    }
    
    private func configuireAvatar() {
        let image = UIImage(named: "avatar.jpeg")
        avatarImageView = UIImageView(image: image)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFit
    }
    
    private func configuireFullnameLabel() {
        fullnameLabel = UILabel()
        fullnameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullnameLabel.font = UIFont.boldSystemFont(ofSize: Metrics.fullnameLabelFontSize)
        fullnameLabel.text = "\(person.name) \(person.surname)"
    }
    
    private func configuireAboutMeLabel() {
        aboutMeLabel = UILabel()
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.numberOfLines = 0
        aboutMeLabel.text = person.aboutMe
    }
    
    private func configuireLayout() {
        let screenSize = UIScreen.main.bounds
        view.backgroundColor = .white
        
        view.addSubview(avatarImageView)
        view.addSubview(fullnameLabel)
        view.addSubview(aboutMeLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Metrics.mediumIndent),
            avatarImageView.heightAnchor.constraint(equalToConstant: screenSize.height / 3),
            avatarImageView.widthAnchor.constraint(equalToConstant: screenSize.width * 0.8),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fullnameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Metrics.largeIndent),
            fullnameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            aboutMeLabel.topAnchor.constraint(equalTo: fullnameLabel.bottomAnchor, constant: Metrics.smallIndent),
            aboutMeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.mediumIndent),
            aboutMeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.mediumIndent)
        ])
    }
}
