//
//  AppCoordinator.swift
//  RandomUserClient
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import UIKit
import CommonUtils
import Intro
import Entities

final class AppCoordinator: Coordinator {
    
    private let serviceProvider: ServiceProvider
    
    public init(navigationController: UINavigationController, serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
        super.init(navigationController: navigationController)
    }
        
    override func start() {
        let coordinatorProvider = IntroCoordinatorProvider(serviceProvider: serviceProvider)
        let coordinator = coordinatorProvider.getCoordinator(navigationController)
        store(coordinator: coordinator)
        coordinator.start()
    }
}
