//
//  SceneDelegate.swift
//  AppLifeCycle
//
//  Created by Riad on 11/24/19.
//  Copyright © 2019 Projectum. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

// -
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    // -
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    // +
    // 3)
    // после того как начало функционировать на переднем плане
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("scene did become Active")
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    // +
    // 4)
    // когда вышли в таск менеджер. Перед тем как активность перейдет на задний план
    func sceneWillResignActive(_ scene: UIScene) {
        print("scene Will resign active")
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    // +
    // 2)
    // перед тем как начнет функционировать на переднем плане
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("scene will enter Foreground")
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    // +
    // 5)
    // после того как приложение ушло на задний план
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("scene did enter Background")
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

