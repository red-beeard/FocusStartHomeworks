//
//  SceneDelegate.swift
//  CollectionApp
//
//  Created by Red Beard on 16.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let tableVC = TableViewController(style: .grouped)
        window?.rootViewController = UINavigationController(rootViewController: tableVC)
        window?.makeKeyAndVisible()
    }

}

