//
//  SettingsStore.swift
//  Settings
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import CommonUtils

struct SettingsState: State {
    
}

enum SettingsAction: Action {
    
}

enum SettingsEffect: Effect {
    
}

final class SettingsStore: Store<SettingsState, SettingsAction, SettingsEffect, SettingsCoordinator> {
    
    override func handle(_ action: SettingsAction, sendEffect: @escaping (SettingsEffect) -> Void, sendAction: @escaping (SettingsAction) -> Void) {
        
    }
    
    override func reduce(_ effect: SettingsEffect, currentState: SettingsState) -> SettingsState {
        
    }
}
