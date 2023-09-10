//
//  MockView.swift
//  CommonUtils
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
@testable import CommonUtils

final class SpyView: BaseViewController<MockStore, MockState, MockAction, MockEffect> {
    
    private (set) var stateUpdated: Bool = false
    private (set) var currentState: MockState?
    
    override func update(withState state: MockState) {
        currentState = state
        stateUpdated = true
    }
}
