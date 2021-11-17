//
//  SceneDelegate.swift
//  myCV
//
//  Created by Red Beard on 12.11.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = TabBarController()
        self.window = window
        window.makeKeyAndVisible()
    }
}

