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
import Entities

struct UsersListState: State {
    let allUsers: [User]
    let users: [User]
    let bookmarks: [User]
}

enum UsersListAction: Action {
    case appear
    case loadNext
    case selected(Int)
    case search(String?)
}

enum UsersListEffect: Effect {
    case setUsers([User])
    case setBookmarks([User])
    case addUsers([User])
    case filterUsers([User])
}

final class UsersListStore: Store<UsersListState, UsersListAction, UsersListEffect, UserCatalogCoordinator> {
    
    private let seed = "unique"
    private let userService: UserService
    private let bookmarkService: BookmarkService
    private let resultsPerPage: Int
    private var page: Int
    
    init(
        initialState: UsersListState = .init(allUsers: [], users: [], bookmarks: []),
        userService: UserService,
        bookmarkService: BookmarkService,
        resultsPerPage: Int = 10,
        page: Int = 1
    ) {
        self.userService = userService
        self.bookmarkService = bookmarkService
        self.resultsPerPage = resultsPerPage
        self.page = page
        super.init(initialState: initialState)
    }
    
    override func handle(_ action: UsersListAction, sendEffect: @escaping (UsersListEffect) -> Void, sendAction: @escaping (UsersListAction) -> Void) {
        switch action {
        case .appear:
            bookmarkService.getBookmarks()
                .subscribe(onSuccess: { bookmarks in
                    sendEffect(.setBookmarks(bookmarks))
                }).disposed(by: disposeBag)
            
            guard currentState.users.isEmpty else { return }
            fetchUsers().subscribe(onSuccess: { newUsers in
                sendEffect(.setUsers(newUsers))
            }).disposed(by: disposeBag)
        case .loadNext:
            fetchUsers().subscribe(onSuccess: { nextUsers in
                sendEffect(.addUsers(nextUsers))
            }).disposed(by: disposeBag)
        case let .selected(index):
            guard !currentState.users.isEmpty, index < currentState.users.count else { return }
            let selectedUser = currentState.users[index]
            if currentState.bookmarks.contains(selectedUser) {
                bookmarkService.deleteBookmark(selectedUser)
                    .subscribe(onSuccess: { bookmarks in
                        sendEffect(.setBookmarks(bookmarks))
                    }).disposed(by: disposeBag)
            } else {
                bookmarkService.addBookmark(selectedUser)
                    .subscribe(onSuccess: { bookmarks in
                        sendEffect(.setBookmarks(bookmarks))
                    }).disposed(by: disposeBag)
            }
            
        case let .search(query):
            if query == nil || query == "" {
                sendEffect(.setUsers(currentState.allUsers))
            } else {
                sendEffect(.filterUsers(currentState.allUsers.filter { $0.email.contains(query!) }))
            }
            break
        }
    }
    
    override func reduce(_ effect: UsersListEffect, currentState: UsersListState) -> UsersListState {
        switch effect {
        case let .setUsers(users):
            return UsersListState(allUsers: users, users: users, bookmarks: currentState.bookmarks)
        case let .addUsers(users):
            return UsersListState(allUsers: currentState.allUsers + users, users: currentState.allUsers + users, bookmarks: currentState.bookmarks)
        case let .filterUsers(users):
            return UsersListState(allUsers: currentState.allUsers, users: users, bookmarks: currentState.bookmarks)
        case let .setBookmarks(bookmarks):
            return UsersListState(allUsers: currentState.allUsers, users: currentState.users, bookmarks: bookmarks)
        }
    }
    
    private func fetchUsers() -> Single<[User]> {
        userService.getUsers(seed: seed, results: resultsPerPage, page: page)
            .observe(on: MainScheduler.asyncInstance)
            .map { [weak self] list in
                self?.page += 1
                return list.results
            }
            .catch({ error in .just([]) })
    }
}
