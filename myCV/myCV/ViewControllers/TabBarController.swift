//
//  ViewController.swift
//  myCV
//
//  Created by Red Beard on 12.11.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurationTabBar()
    }
    
    private func configurationTabBar() {
        let aboutMeVC = AboutMeViewController()
        aboutMeVC.tabBarItem = UITabBarItem(
            title: "About me",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        let developerVC = DeveloperViewController()
        developerVC.tabBarItem = UITabBarItem(
            title: "Developer",
            image: UIImage(systemName: "macpro.gen2"),
            selectedImage: UIImage(systemName: "macpro.gen2.fill")
        )

        let hobbyVC = HobbyViewController()
        hobbyVC.tabBarItem = UITabBarItem(
            title: "Hobby",
            image: UIImage(systemName: "gamecontroller"),
            selectedImage: UIImage(systemName: "gamecontroller.fill")
        )
        
        setViewControllers([aboutMeVC, developerVC, hobbyVC], animated: false)
    }

}

