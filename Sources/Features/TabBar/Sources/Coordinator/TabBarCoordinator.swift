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
        navigationController.setNavigationBarHidden(true, animated: false)
        super.init(navigationController: navigationController)
    }
    
    public override func start() {
        let tabBarController = getTabBarController()
        
        let userCatalogNavigationController = getSubNavigationController()
        let userCatalogCoordinator = userCatalogCoordinatorProvider.getCoordinator(userCatalogNavigationController)
        store(coordinator: userCatalogCoordinator)
        userCatalogCoordinator.start()
        userCatalogNavigationController.viewControllers.first?.navigationItem.title = TabBarStrings.Users.Tab.Item.title
        userCatalogNavigationController.tabBarItem = getTabBarItem(icon: .person(filled: false), selectedIcon: .person(filled: true))
        
        let bookmarksNavigationController = getSubNavigationController()
        let bookmarksCoordinator = bookmarksCoordinatorProvider.getCoordinator(bookmarksNavigationController)
        store(coordinator: bookmarksCoordinator)
        bookmarksCoordinator.start()
        bookmarksNavigationController.viewControllers.first?.navigationItem.title = TabBarStrings.Bookmarks.Tab.Item.title
        bookmarksNavigationController.tabBarItem = getTabBarItem(icon: .bookmark(filled: false), selectedIcon: .bookmark(filled: true))
        
        let settingsNavigationController = getSubNavigationController()
        let settingsCoordinator = settingsCoordinatorProvider.getCoordinator(settingsNavigationController)
        store(coordinator: bookmarksCoordinator)
        settingsCoordinator.start()
        settingsNavigationController.viewControllers.first?.navigationItem.title = TabBarStrings.Settings.Tab.Item.title
        settingsNavigationController.tabBarItem = getTabBarItem(icon: .gearshape(filled: false), selectedIcon: .gearshape(filled: true))

        tabBarController.setViewControllers([
            userCatalogNavigationController,
            bookmarksNavigationController,
            settingsNavigationController
        ], animated: true)
        
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    private func getSubNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        let appearance = UINavigationBarAppearance()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: CommonUIAsset.contentPrimary.color]
        appearance.titleTextAttributes = titleTextAttributes
        appearance.largeTitleTextAttributes = titleTextAttributes
        appearance.backgroundColor = CommonUIAsset.containerPrimary.color
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        return navigationController

    }
    
    private func getTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = CommonUIAsset.containerPrimary.color
        tabBarController.tabBar.tintColor = CommonUIAsset.actionPrimary.color
        tabBarController.tabBar.unselectedItemTintColor = CommonUIAsset.contentPrimary.color
        tabBarController.tabBar.backgroundColor = CommonUIAsset.containerPrimary.color
        tabBarController.tabBar.standardAppearance = tabBarAppearance
        return tabBarController
    }
    
    private func getTabBarItem(icon: CommonUIAsset.Icons, selectedIcon: CommonUIAsset.Icons) -> UITabBarItem {
        UITabBarItem(
            title: nil,
            image: icon.image,
            selectedImage: selectedIcon.image
        )
    }
}
