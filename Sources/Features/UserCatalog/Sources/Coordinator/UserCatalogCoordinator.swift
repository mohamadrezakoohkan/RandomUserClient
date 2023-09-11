//
//  UserCatalogCoordinator.swift
//  UserCatalog
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import UIKit
import CommonUtils
import Services

public final class UserCatalogCoordinator: Coordinator {
    
    private let userService: UserService
    
    public init(navigationController: UINavigationController, userService: UserService) {
        self.userService = userService
        super.init(navigationController: navigationController)
    }
    
    public override func start() {
        let store = UsersListStore(initialState: .init(), userService: userService)
        store.coordinator = self
        let viewController = UsersListViewController(store: store)
        navigationController.pushViewController(viewController, animated: true)
    }
}
