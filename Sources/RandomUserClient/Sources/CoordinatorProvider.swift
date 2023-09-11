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
import Intro
import TabBar
import UserCatalog
import Bookmarks
import Settings

final class IntroCoordinatorProvider: ExternalCoordinatorProvider {
    func getCoordinator(_ navigationController: UINavigationController) -> Coordinator {
        IntroCoordinator(
            navigationController: navigationController,
            tabBarCoordinatorProvider: TabBarCoordinatorProvider()
        )
    }
}

final class TabBarCoordinatorProvider: ExternalCoordinatorProvider {
    func getCoordinator(_ navigationController: UINavigationController) -> Coordinator {
        TabBarCoordinator(
            navigationController: navigationController,
            userCatalogCoordinatorProvider: UserCatalogCoordinatorProvider(),
            bookmarksCoordinatorProvider: BookmarksCoordinatorProvider(),
            settingsCoordinatorProvider: SettingsCoordinatorProvider()
        )
    }
}

final class UserCatalogCoordinatorProvider: ExternalCoordinatorProvider {
    func getCoordinator(_ navigationController: UINavigationController) -> Coordinator {
        UserCatalogCoordinator(
            navigationController: navigationController
        )
    }
}

final class BookmarksCoordinatorProvider: ExternalCoordinatorProvider {
    func getCoordinator(_ navigationController: UINavigationController) -> Coordinator {
        BookmarksCoordinator(
            navigationController: navigationController
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
