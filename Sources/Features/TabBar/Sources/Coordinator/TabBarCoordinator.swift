//
//  TabBarCoordinator.swift
//  TabBar
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import UIKit
import CommonUtils
import CommonUI

public final class TabBarCoordinator: Coordinator {
    
    let userCatalogCoordinatorProvider: ExternalCoordinatorProvider
    let bookmarksCoordinatorProvider: ExternalCoordinatorProvider
    let settingsCoordinatorProvider: ExternalCoordinatorProvider

    public init(
        navigationController: UINavigationController,
        userCatalogCoordinatorProvider: ExternalCoordinatorProvider,
        bookmarksCoordinatorProvider: ExternalCoordinatorProvider,
        settingsCoordinatorProvider: ExternalCoordinatorProvider
    ) {
        self.userCatalogCoordinatorProvider = userCatalogCoordinatorProvider
        self.bookmarksCoordinatorProvider = bookmarksCoordinatorProvider
        self.settingsCoordinatorProvider = settingsCoordinatorProvider
        super.init(navigationController: navigationController)
    }
    
    public override func start() {
        let tabBarController = UITabBarController()
        
        let userCatalogNavigationController = UINavigationController()
        let userCatalogCoordinator = userCatalogCoordinatorProvider.getCoordinator(userCatalogNavigationController)
        store(coordinator: userCatalogCoordinator)
        userCatalogCoordinator.start()
        userCatalogNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: CommonUIAsset.Icons.person(filled: false).image,
            selectedImage: CommonUIAsset.Icons.person(filled: true).image
        )
        
        let bookmarksNavigationController = UINavigationController()
        let bookmarksCoordinator = bookmarksCoordinatorProvider.getCoordinator(bookmarksNavigationController)
        store(coordinator: bookmarksCoordinator)
        bookmarksCoordinator.start()
        bookmarksNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: CommonUIAsset.Icons.bookmark(filled: false).image,
            selectedImage: CommonUIAsset.Icons.bookmark(filled: true).image
        )
        
        let settingsNavigationController = UINavigationController()
        let settingsCoordinator = settingsCoordinatorProvider.getCoordinator(settingsNavigationController)
        store(coordinator: bookmarksCoordinator)
        settingsCoordinator.start()
        settingsNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: CommonUIAsset.Icons.gearshape(filled: false).image,
            selectedImage: CommonUIAsset.Icons.gearshape(filled: true).image
        )
        
        tabBarController.tabBar.tintColor = CommonUIAsset.actionPrimary.color
        tabBarController.setViewControllers([
            userCatalogNavigationController,
            bookmarksNavigationController,
            settingsNavigationController
        ], animated: true)
        
        navigationController.pushViewController(tabBarController, animated: true)
    }
}
