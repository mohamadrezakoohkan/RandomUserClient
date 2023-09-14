//
//  SceneDelegate.swift
//  RandomUserClient
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import UIKit
import CommonUtils
import Networking
import Storage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let httpClient = HttpClient()
        let storage = CoreDataStorage()
        let serviceProvider = ServiceProvider(httpClient: httpClient, storage: storage)
        let navigationController = UINavigationController()
        coordinator = AppCoordinator(navigationController: navigationController, serviceProvider: serviceProvider)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        coordinator?.start()
    }
}

