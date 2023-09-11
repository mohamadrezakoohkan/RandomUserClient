//
//  IntroCoordinator.swift
//  Intro
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import CommonUtils
import UIKit

public final class IntroCoordinator: Coordinator {
    
    let tabBarCoordinatorProvider: ExternalCoordinatorProvider
    
    public init(
        navigationController: UINavigationController,
        tabBarCoordinatorProvider: ExternalCoordinatorProvider
    ) {
        self.tabBarCoordinatorProvider = tabBarCoordinatorProvider
        super.init(navigationController: navigationController)
    }    

    public override func start() {
        // Following line dismisses any presented controller on top of startup to Restart the flow from the beginning
        if let presentedController = navigationController.presentedViewController {
            presentedController.dismiss(animated: true)
        } else {
            let store = StartupStore(initialState: .init(isLoading: true, isConnected: nil))
            store.coordinator = self
            let viewController = StartupViewController(store: store)
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func showTabBar() {
        let tabBarNavigationController = UINavigationController()
        let coordinator = tabBarCoordinatorProvider.getCoordinator(tabBarNavigationController)
        store(coordinator: coordinator)
        coordinator.start()
        tabBarNavigationController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarNavigationController, animated: true)
    }
}
