//
//  MockView.swift
//  CommonUtils
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
@testable import CommonUtils

final class SpyView: ViewController<MockStore> {
    
    private (set) var stateUpdated: Bool = false
    
    override func update(withState state: MockState) {
        super.update(withState: state)
        stateUpdated = true
    }
}
