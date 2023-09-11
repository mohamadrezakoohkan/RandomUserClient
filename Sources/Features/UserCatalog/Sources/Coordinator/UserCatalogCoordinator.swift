//
//  UserCatalogCoordinator.swift
//  UserCatalog
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import CommonUtils

public final class UserCatalogCoordinator: Coordinator {
    
    public override func start() {
        let store = UsersListStore(initialState: .init())
        store.coordinator = self
        let viewController = UsersListViewController(store: store)
        navigationController.pushViewController(viewController, animated: true)
    }
}
