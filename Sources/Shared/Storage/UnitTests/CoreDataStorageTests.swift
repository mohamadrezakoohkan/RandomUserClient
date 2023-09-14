//
//  CoreDataStorageTests.swift
//  StorageUnitTests
//
//  Created by Mohammad reza on 14.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import XCTest
import CoreData
import RxSwift
@testable import Storage

class CoreDataStorageTests: XCTestCase {
    var disposeBag = DisposeBag()
    var coreDataStorage: CoreDataStorage!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        coreDataStorage = CoreDataStorage(inMemory: true)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStorage.destroy()
    }

    func testCreateStorageObject() {
        let expectation = expectation(description: "Wait for fetching objects")

        let id = "1"
        let name = "TestObject"
        let content = "{\"key\":\"value\"}"
        
        coreDataStorage.createStorageObject(id: id, name: name, content: content)
        coreDataStorage.fetchAllStorageObjects()
            .subscribe { storageObjects in
                if storageObjects.count == 1 {
                    let storageObject = storageObjects.first
                    XCTAssertEqual(storageObject?.id, id)
                    XCTAssertEqual(storageObject?.name, name)
                    XCTAssertEqual(storageObject?.content, content)
                    expectation.fulfill()
                }
            } onFailure: { error in
                XCTFail("Failed to fetch storage objects: \(error)")
            }.disposed(by: disposeBag)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchAllStorageObjects() {
        let expectation = expectation(description: "Wait for fetching objects")
        
        coreDataStorage.createStorageObject(id: "1", name: "RandomObject", content: "{}")
        coreDataStorage.createStorageObject(id: "2", name: "RandomObject", content: "{}")

        coreDataStorage.fetchAllStorageObjects()
            .subscribe { objects in
                if objects.count == 2 {
                    expectation.fulfill()
                }
            } onFailure: { error in
                XCTFail("Failed to fetch storage objects: \(error)")
            }.disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
