//
//  UsersListStore.swift
//  UserCatalog
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import CommonUtils
import Services
import RxSwift

struct UsersListState: State {
    
}

enum UsersListAction: Action {
    case appear
}

enum UsersListEffect: Effect {
    
}

final class UsersListStore: Store<UsersListState, UsersListAction, UsersListEffect, UserCatalogCoordinator> {
    
    private let userService: UserService
    
    init(initialState: UsersListState = .init(), userService: UserService) {
        self.userService = userService
        super.init(initialState: initialState)
    }
    
    override func handle(_ action: UsersListAction, currentState: UsersListState, sendEffect: @escaping (UsersListEffect) -> Void, sendAction: @escaping (UsersListAction) -> Void) {
        userService.getUsers(results: 1, page: 1)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onSuccess: { list in
                print("Success getusers", list)
            }, onFailure: { error in
                print("Getusers failed", error)
            }, onDisposed: {
                print("Getusers disposed")
            }).disposed(by: disposeBag)
    }
    
    override func reduce(_ effect: UsersListEffect, currentState: UsersListState) -> UsersListState {
        
    }
}
