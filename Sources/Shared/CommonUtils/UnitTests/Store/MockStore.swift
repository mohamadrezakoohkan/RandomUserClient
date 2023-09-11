//
//  MockStore.swift
//  CommonUtils
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
@testable import CommonUtils

struct MockState: State {
    
    let amount: Int
    
    init(amount: Int = 0) {
        self.amount = amount
    }
}

enum MockAction: Action {
    case increase
    case decrease
}

enum MockEffect: Effect {
    case setAmount(Int)
}

final class MockStore: Store<MockState, MockAction, MockEffect, Coordinator> {
 
    override func handle(_ action: MockAction, currentState: MockState, sendEffect: @escaping (MockEffect) -> Void, sendAction: @escaping (MockAction) -> Void) {
        switch action {
        case .increase:
            sendEffect(.setAmount(currentState.amount + 1))
        case .decrease:
            sendEffect(.setAmount(currentState.amount - 1))
        }
    }
    
    override func reduce(_ effect: MockEffect, currentState: MockState) -> MockState {
        switch effect {
        case let .setAmount(newAmount):
            return MockState(amount: newAmount)
        }
    }
}
