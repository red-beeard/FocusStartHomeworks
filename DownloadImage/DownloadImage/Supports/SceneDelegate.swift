//
//  SceneDelegate.swift
//  DownloadImage
//
//  Created by Red Beard on 12.12.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        
        let downloadListVC = DownloadListAssembly.build()
        let navController = UINavigationController(rootViewController: downloadListVC)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }

}

