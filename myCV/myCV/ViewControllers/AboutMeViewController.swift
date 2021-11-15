//
//  AboutMeViewController.swift
//  myCV
//
//  Created by Red Beard on 12.11.2021.
//

import UIKit

final class AboutMeViewController: UIViewController {
    
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
        fullnameLabel.font = UIFont.boldSystemFont(ofSize: 30)
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
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.heightAnchor.constraint(equalToConstant: screenSize.height / 3),
            avatarImageView.widthAnchor.constraint(equalToConstant: screenSize.width * 0.8),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fullnameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 30),
            fullnameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            aboutMeLabel.topAnchor.constraint(equalTo: fullnameLabel.bottomAnchor, constant: 10),
            aboutMeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            aboutMeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
