//
//  MockBookmarkService.swift
//  Services
//
//  Created by Mohammad reza on 14.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import Storage
import Entities
import RxSwift

public class MockBookmarkService: BookmarkService {
    
    public var mockBookmarks: [User] = []
    
    public init() { }
    
    public func getBookmarks() -> Single<[User]> {
        Single.just(mockBookmarks)
    }
    
    public func addBookmark(_ user: User) -> Single<[User]> {
        Single.just(mockBookmarks)
    }
    
    public func deleteBookmark(_ user: Entities.User) -> Single<[User]> {
        Single.just(mockBookmarks)
    }
}
