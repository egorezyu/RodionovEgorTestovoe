//
//  SceneDelegate.swift
//  RodionovEgorTestovoe
//
//  Created by Егор Родионов on 6.07.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController.init(rootViewController: ViewController())
        
//        navigationController.title = "Main"
        
        navigationController.tabBarItem.image = UIImage(systemName: "list.dash")?.withTintColor(.white,renderingMode: .alwaysOriginal)
        
        
        let cont = UIViewController()
//        cont.title = "cont"
        cont.tabBarItem.image = UIImage(systemName: "purchased")?.withTintColor(.white,renderingMode: .alwaysOriginal)
        let cont2 = UIViewController()
//        cont2.title = "cont2"
        cont2.tabBarItem.image = UIImage(systemName: "leaf")?.withTintColor(.white,renderingMode: .alwaysOriginal)
        
        let tabBar = UITabBarController()
        tabBar.tabBar.backgroundColor = .black
        tabBar.tabBar.layer.cornerRadius = 25
        
        tabBar.setViewControllers([navigationController,cont,cont2], animated: false)
        tabBar.modalPresentationStyle = .fullScreen
        
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

