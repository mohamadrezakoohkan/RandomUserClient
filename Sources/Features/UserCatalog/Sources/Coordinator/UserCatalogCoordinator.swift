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
    private let bookmarkService: BookmarkService
    
    public init(navigationController: UINavigationController, userService: UserService, bookmarkService: BookmarkService) {
        self.userService = userService
        self.bookmarkService = bookmarkService
        super.init(navigationController: navigationController)
    }
    
    public override func start() {
        let store = UsersListStore(
            initialState: .init(allUsers: [], users: [], bookmarks: []),
            userService: userService,
            bookmarkService: bookmarkService
        )
        store.coordinator = self
        let viewController = UsersListViewController(store: store)
        navigationController.pushViewController(viewController, animated: true)
    }
}
