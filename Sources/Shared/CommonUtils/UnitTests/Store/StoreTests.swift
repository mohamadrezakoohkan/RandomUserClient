//
//  StoreTests.swift
//  CommonUtils
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import XCTest
@testable import CommonUtils

final class StoreTests: XCTestCase {
    
    var store: MockStore!
    var view: SpyView!
    let initialState = MockState(amount: 0)
    
    override func setUp() {
        super.setUp()
        store = MockStore(initialState: initialState)
        view = SpyView()
        view.store = store
    }
    
    override func tearDown() {
        super.tearDown()
        store = nil
        view = nil
    }
    
    func testViewUpdateWhenLoaded() {
        XCTAssertNil(view.currentState)
        XCTAssertFalse(view.stateUpdated)
        view.viewDidLoad()
        XCTAssertTrue(view.stateUpdated)
        XCTAssertEqual(view.currentState?.amount, initialState.amount)
    }
    
    func testViewSubscribeForUpdateAndActions() {
        XCTAssertNil(view.currentState)
        view.viewDidLoad()
        view.dispatch(action: .increase)
        XCTAssertEqual(view.currentState?.amount, 0)
        view.viewDidAppear(true)
        XCTAssertEqual(view.currentState?.amount, 0)
        view.dispatch(action: .increase)
        XCTAssertEqual(view.currentState?.amount, 1)
        view.dispatch(action: .increase)
        view.dispatch(action: .increase)
        XCTAssertEqual(view.currentState?.amount, 3)
        view.dispatch(action: .decrease)
        XCTAssertEqual(view.currentState?.amount, 3)
    }

    func testViewUnsubscribeForUpdateAndActions() {
        XCTAssertNil(view.currentState)
        view.viewDidLoad()
        view.viewDidAppear(true)
        view.dispatch(action: .increase)
        XCTAssertEqual(view.currentState?.amount, 1)
        view.viewDidDisappear(true)
        view.dispatch(action: .decrease)
        XCTAssertEqual(view.currentState?.amount, 1)
        view.viewDidAppear(true)
        view.dispatch(action: .increase)
        XCTAssertEqual(view.currentState?.amount, 2)
    }
}
