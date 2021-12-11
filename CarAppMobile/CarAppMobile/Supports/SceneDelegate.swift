//
//  SceneDelegate.swift
//  CarAppMobile
//
//  Created by Red Beard on 02.12.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        
        let selectBrandVC = SelectBrandAssembly.build()
        let navController = UINavigationController(rootViewController: selectBrandVC)
        
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    
}

