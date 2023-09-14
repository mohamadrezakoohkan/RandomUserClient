//
//  StartupStore.swift
//  Intro
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import CommonUtils

struct StartupState: State {
    let isLoading: Bool
    let isConnected: Bool?
}

enum StartupAction: Action {
    case appear
    case connect
    case disappear
}

enum StartupEffect: Effect {
    case setLoading(Bool)
    case setConnection(Bool)
}

final class StartupStore: Store<StartupState, StartupAction, StartupEffect, IntroCoordinator> {
    
    override func handle(_ action: StartupAction, sendEffect: @escaping (StartupEffect) -> Void, sendAction: @escaping (StartupAction) -> Void) {
        switch action {
        case .appear:
            sendEffect(.setLoading(true))
            sendAction(.connect)
        case .connect:
            //
            // This lines of code demonstrate networking tasks or connection to a socket server
            //
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [self] in
                coordinator?.showTabBar()
                sendEffect(.setConnection(true))
            })
        case .disappear:
            sendEffect(.setLoading(false))
        }
    }
    
    override func reduce(_ effect: StartupEffect, currentState: StartupState) -> StartupState {
        switch effect {
        case let .setLoading(isLoading):
            return StartupState(isLoading: isLoading, isConnected: currentState.isConnected)
        case let .setConnection(isConncected):
            return StartupState(isLoading: currentState.isLoading, isConnected: isConncected)
        }
    }
}
