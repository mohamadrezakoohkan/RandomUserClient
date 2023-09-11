//
//  BookmarksListStore.swift
//  Bookmarks
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//


import Foundation
import CommonUtils

struct BookmarksListState: State {
    
}

enum BookmarksListAction: Action {
    
}

enum BookmarksListEffect: Effect {
    
}

final class BookmarksListStore: Store<BookmarksListState, BookmarksListAction, BookmarksListEffect, BookmarksCoordinator> {
    
    override func handle(_ action: BookmarksListAction, currentState: BookmarksListState, sendEffect: @escaping (BookmarksListEffect) -> Void, sendAction: @escaping (BookmarksListAction) -> Void) {
        
    }
    
    override func reduce(_ effect: BookmarksListEffect, currentState: BookmarksListState) -> BookmarksListState {
        
    }
}
