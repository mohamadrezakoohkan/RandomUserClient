//
//  BookmarkService.swift
//  Services
//
//  Created by Mohammad reza on 14.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//
import Foundation
import Storage
import Entities
import RxSwift

public protocol BookmarkService {
    func getBookmarks() -> Single<[User]>
    func addBookmark(_ user: User) -> Single<[User]>
    func deleteBookmark(_ user: User) -> Single<[User]>

}

public struct BookmarkServiceProvider: BookmarkService {
    
    private let storage: Storage
    private let serializer: UserSerializer
    
    private func primaryKey(_ user: User) -> String {
        user.id.value ?? user.email
    }
    
    public init(
        storage: Storage,
        serializer: UserSerializer = UserSerializer()
    ) {
        self.storage = storage
        self.serializer = serializer
    }
    
    public func getBookmarks() -> Single<[User]> {
        storage.fetchAllStorageObjects()
            .flatMap { [self] (objects: [StorageObjectProtocol]) -> Single<[User]> in
                let users: [User] = try objects.compactMap { object -> User? in
                    guard let jsonData = object.content?.data(using: .utf8) else { return nil }
                    return try serializer.decoder.decode(User.self, from: jsonData)
                }
                return Single.just(users)
            }
    }
    
    public func addBookmark(_ user: Entities.User) -> Single<[User]> {
        guard let jsonString = serializer.jsonString(user) else { return getBookmarks() }
        storage.createStorageObject(
            id: primaryKey(user),
            name: String(describing: User.self),
            content: jsonString
        )
        return getBookmarks()
    }
    
    public func deleteBookmark(_ user: Entities.User) -> Single<[User]> {
        let primaryKey = primaryKey(user)

        return storage.fetchAllStorageObjects()
            .map { (objects: [StorageObjectProtocol]) -> [StorageObjectProtocol] in
                objects.filter { $0.id == primaryKey }
            }
            .flatMap { [self] uniqueObjects in
                uniqueObjects.forEach { object in
                    storage.deleteStorageObject(storageObject: object)
                }
                return getBookmarks()
            }
    }
}
