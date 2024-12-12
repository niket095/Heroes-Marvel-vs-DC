//
//  SceneDelegate.swift
//  Heroes Marvel vs DC
//
//  Created by Nikita Putilov on 11.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let rootViewController = MainViewController()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
