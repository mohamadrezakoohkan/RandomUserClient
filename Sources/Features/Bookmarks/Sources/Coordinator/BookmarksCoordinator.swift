//
//  BookmarksCoordinator.swift
//  Bookmarks
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import CommonUtils

public final class BookmarksCoordinator: Coordinator {
    
    public override func start() {
        let store = BookmarksListStore(initialState: .init())
        store.coordinator = self
        let viewController = BookmarksListViewController(store: store)
        navigationController.pushViewController(viewController, animated: true)
    }
}
