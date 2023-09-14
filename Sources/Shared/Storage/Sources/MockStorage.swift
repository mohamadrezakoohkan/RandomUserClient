//
//  MockStorage.swift
//  StorageUnitTests
//
//  Created by Mohammad reza on 14.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

/*
 
This Mock must be placed in another module shared between unit tests not here, this Mock should only used in unit tests
*/

import Foundation
import RxSwift

public class MockStorageObject: StorageObjectProtocol {
    public var name: String?
    public var id: String?
    public var content: String?
    
    public init(name: String? = nil, id: String? = nil, content: String? = nil) {
        self.name = name
        self.id = id
        self.content = content
    }
}

public class MockStorage: Storage {
    public var storageObjects: [MockStorageObject]
    
    public init(storageObjects: [MockStorageObject] = []) {
        self.storageObjects = storageObjects
    }
    
    public func fetchAllStorageObjects() -> Single<[StorageObjectProtocol]> {
        return Single.just(storageObjects)
    }
    
    public  func createStorageObject(id: String, name: String, content: String) {
        let storageObject = MockStorageObject()
        storageObject.id = id
        storageObject.name = name
        storageObject.content = content
        storageObjects.append(storageObject)
    }
    
    public func deleteStorageObject(storageObject: StorageObjectProtocol) {
        storageObjects.removeAll { $0.id == storageObject.id }
    }
}
