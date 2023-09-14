//
//  BookmarksListStore.swift
//  Bookmarks
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//


import Foundation
import CommonUtils
import Entities
import Services
import RxSwift

struct BookmarksListState: State {
    let bookmarks: [User]
    
    init(bookmarks: [User] = []) {
        self.bookmarks = bookmarks
    }
}

enum BookmarksListAction: Action {
    case appear
    case selected(Int)
}

enum BookmarksListEffect: Effect {
    case setBookmarks([User])
}

final class BookmarksListStore: Store<BookmarksListState, BookmarksListAction, BookmarksListEffect, BookmarksCoordinator> {
    
    private let bookmarkService: BookmarkService
    
    init(initialState: BookmarksListState, schedular: ImmediateSchedulerType = MainScheduler.asyncInstance, bookmarkService: BookmarkService) {
        self.bookmarkService = bookmarkService
        super.init(initialState: initialState, schedular: schedular)
    }
    
    override func handle(_ action: BookmarksListAction, sendEffect: @escaping (BookmarksListEffect) -> Void, sendAction: @escaping (BookmarksListAction) -> Void) {
        switch action {
        case .appear:
            bookmarkService.getBookmarks()
                .subscribe(onSuccess: { users in
                    sendEffect(.setBookmarks(users))
                }).disposed(by: disposeBag)
        case let .selected(index):
            guard !currentState.bookmarks.isEmpty, index < currentState.bookmarks.count else { return }
            let selectedBookmark = currentState.bookmarks[index]
            if currentState.bookmarks.contains(selectedBookmark) {
                bookmarkService.deleteBookmark(selectedBookmark)
                    .subscribe(onSuccess: { bookmarks in
                        sendEffect(.setBookmarks(bookmarks))
                    }).disposed(by: disposeBag)
            } else {
                bookmarkService.addBookmark(selectedBookmark)
                    .subscribe(onSuccess: { bookmarks in
                        sendEffect(.setBookmarks(bookmarks))
                    }).disposed(by: disposeBag)
            }
        }
    }
    
    override func reduce(_ effect: BookmarksListEffect, currentState: BookmarksListState) -> BookmarksListState {
        switch effect {
        case let .setBookmarks(bookmarks):
            return BookmarksListState(bookmarks: bookmarks)
        }
        
    }
}
