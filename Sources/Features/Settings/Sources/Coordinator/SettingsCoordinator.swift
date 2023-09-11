//
//  SettingsCoordinator.swift
//  Settings
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import CommonUtils

public final class SettingsCoordinator: Coordinator {
    
    public override func start() {
        let store = SettingsStore(initialState: .init())
        store.coordinator = self
        let viewController = SettingsViewController(store: store)
        navigationController.pushViewController(viewController, animated: true)
    }
}
