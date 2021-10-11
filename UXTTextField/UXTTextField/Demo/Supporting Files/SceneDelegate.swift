//
//  SceneDelegate.swift
//  UXTTextField
//
//  Created by taehy.k on 2021/10/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let usageViewController = UsageViewController()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: usageViewController)
        window?.makeKeyAndVisible()
    }
}

