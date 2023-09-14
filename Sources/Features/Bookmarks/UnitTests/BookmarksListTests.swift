//
//  BookmarksListTests.swift
//  BookmarksUnitTests
//
//  Created by Mohammad reza on 14.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import XCTest
import RxSwift
import Services
import Entities
@testable import Bookmarks

class BookmarksListStoreTests: XCTestCase {
    
    var scheduler: CurrentThreadScheduler!
    var disposeBag: DisposeBag!
    
    var mockBookmarkService: MockBookmarkService!
    var store: BookmarksListStore!
    
    override func setUp() {
        super.setUp()
        scheduler = CurrentThreadScheduler.instance
        disposeBag = DisposeBag()
        
        mockBookmarkService = MockBookmarkService()
        store = BookmarksListStore(
            initialState: BookmarksListState(),
            schedular: scheduler,
            bookmarkService: mockBookmarkService
        )
        store.subscribe()
    }
    
    override func tearDown() {
        super.tearDown()
        store.unsubscribe()
        scheduler = nil
        disposeBag = nil
        mockBookmarkService = nil
        store = nil
    }
    
    func testAppearAction_withEmptyBookmarks() {
        let expectation = expectation(description: "Receive empty bookmarks")
        mockBookmarkService.mockBookmarks = []
        store.action.onNext(.appear)
        store.state.subscribe(onNext: {
            if $0.bookmarks.isEmpty {
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSelectAction_withEmptyBookmarks() throws {
        let expectation = expectation(description: "Receive empty bookmarks")
        mockBookmarkService.mockBookmarks = []
        store.action.onNext(.appear)
        store.action.onNext(.selected(0))
        store.state.subscribe(onNext: {
            if $0.bookmarks.count == 0 {
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSelectAction_withLoadedBookmarks() throws {
        let expectation = expectation(description: "Receive empty bookmarks")
        mockBookmarkService.mockBookmarks = [try User.mock()]
        store.action.onNext(.appear)
        store.action.onNext(.selected(0))
        store.state.subscribe(onNext: {
            if $0.bookmarks.count == 0 {
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
