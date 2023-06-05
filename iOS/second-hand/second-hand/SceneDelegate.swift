//
//  SceneDelegate.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let mainViewController = SecondHandTabBarController()
        
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }
    
}

