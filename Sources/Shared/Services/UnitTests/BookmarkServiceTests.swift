//
//  BookmarkServiceTests.swift
//  ServicesUnitTests
//
//  Created by Mohammad reza on 14.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import XCTest
import RxSwift
import Storage
import Entities
@testable import Services

class BookmarkServiceTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    var mockStorage: MockStorage!
    var bookmarkService: BookmarkServiceProvider!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        mockStorage = MockStorage()
        bookmarkService = BookmarkServiceProvider(storage: mockStorage)
    }

    func testAddAndDeleteBookmark() throws {
        let user = try User.mock()
        let expectation = expectation(description: "Add new bookmark")
        expectation.expectedFulfillmentCount = 2
        
        bookmarkService.addBookmark(user)
            .subscribe(onSuccess: { [weak self] bookmarks in
                guard let self else { return }
                
                if bookmarks.count == 1 {
                    expectation.fulfill()
                }
                
                self.bookmarkService.deleteBookmark(user)
                    .subscribe { newBookmarks in
                        if newBookmarks.count == 0 {
                            expectation.fulfill()
                        }
                    } onFailure: { error in
                        XCTFail("Error: \(error)")
                    }.disposed(by: self.disposeBag)
                
            }, onFailure: { error in
                XCTFail("Error: \(error)")
            }).disposed(by: disposeBag)
        
        
        wait(for: [expectation], timeout: 1.0)
    }
}
