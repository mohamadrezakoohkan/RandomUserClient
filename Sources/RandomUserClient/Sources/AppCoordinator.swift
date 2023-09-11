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

final class AppCoordinator: Coordinator {
    
    override func start() {
        let coordinator = IntroCoordinatorProvider().getCoordinator(navigationController)
        store(coordinator: coordinator)
        coordinator.start()
    }
}
