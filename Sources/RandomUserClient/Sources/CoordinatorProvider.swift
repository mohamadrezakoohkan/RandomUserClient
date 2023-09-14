//
//  CoordinatorProvider.swift
//  RandomUserClient
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import UIKit
import CommonUtils
import Services
import Intro
import TabBar
import UserCatalog
import Bookmarks
import Settings


final class IntroCoordinatorProvider: ExternalCoordinatorProvider {
    
    fileprivate let serviceProvider: ServiceProvider
    
    internal init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func getCoordinator(_ navigationController: UINavigationController) -> Coordinator {
        IntroCoordinator(
            navigationController: navigationController,
            tabBarCoordinatorProvider: TabBarCoordinatorProvider(serviceProvider: serviceProvider)
        )
    }
}

final class TabBarCoordinatorProvider: ExternalCoordinatorProvider {
    
    fileprivate let serviceProvider: ServiceProvider
    
    fileprivate init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func getCoordinator(_ navigationController: UINavigationController) -> Coordinator {
        TabBarCoordinator(
            navigationController: navigationController,
            userCatalogCoordinatorProvider: UserCatalogCoordinatorProvider(serviceProvider: serviceProvider),
            bookmarksCoordinatorProvider: BookmarksCoordinatorProvider(serviceProvider: serviceProvider),
            settingsCoordinatorProvider: SettingsCoordinatorProvider()
        )
    }
}

final class UserCatalogCoordinatorProvider: ExternalCoordinatorProvider {
    
    fileprivate let serviceProvider: ServiceProvider
    
    fileprivate init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func getCoordinator(_ navigationController: UINavigationController) -> Coordinator {
        UserCatalogCoordinator(
            navigationController: navigationController,
            userService: serviceProvider.userService,
            bookmarkService: serviceProvider.bookmarkService
        )
    }
}

final class BookmarksCoordinatorProvider: ExternalCoordinatorProvider {
    
    fileprivate let serviceProvider: ServiceProvider
    
    fileprivate init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func getCoordinator(_ navigationController: UINavigationController) -> Coordinator {
        BookmarksCoordinator(
            navigationController: navigationController,
            bookmarkService: serviceProvider.bookmarkService
        )
    }
}

final class SettingsCoordinatorProvider: ExternalCoordinatorProvider {
    func getCoordinator(_ navigationController: UINavigationController) -> Coordinator {
        SettingsCoordinator(
            navigationController: navigationController
        )
    }
}
