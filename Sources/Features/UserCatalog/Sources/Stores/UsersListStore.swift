//
//  UsersListStore.swift
//  UserCatalog
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import CommonUtils

struct UsersListState: State {
    
}

enum UsersListAction: Action {
    
}

enum UsersListEffect: Effect {
    
}

final class UsersListStore: Store<UsersListState, UsersListAction, UsersListEffect, UserCatalogCoordinator> {
    
    override func handle(_ action: UsersListAction, currentState: UsersListState, sendEffect: @escaping (UsersListEffect) -> Void, sendAction: @escaping (UsersListAction) -> Void) {
        
    }
    
    override func reduce(_ effect: UsersListEffect, currentState: UsersListState) -> UsersListState {
        
    }
}
