//
//  IntroCoordinator.swift
//  Intro
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import CommonUtils

final class IntroCoordinator: Coordinator {
    
    override func start() {
        let store = StartupStore(initialState: .init(isLoading: true, isConnected: nil))
        store.coordinator = self
        let viewController = StartupViewController()
        viewController.store = store
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showTabBar() {
        
    }
    
}
