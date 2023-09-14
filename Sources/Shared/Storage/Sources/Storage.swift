//
//  Storage.swift
//  Storage
//
//  Created by Mohammad reza on 14.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import RxSwift

public protocol StorageObjectProtocol {
    var id: String? { get set }
    var name: String? { get set }
    var content: String? { get set }
}

public protocol Storage {
    func createStorageObject(id: String, name: String, content: String)
    func fetchAllStorageObjects() -> Single<[StorageObjectProtocol]>
    func deleteStorageObject(storageObject: StorageObjectProtocol)
}
