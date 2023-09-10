//
//  ViewStore.swift
//  CommonUtils
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import RxSwift

public protocol ViewStore {
    associatedtype AnyState: State
    associatedtype AnyAction: Action
    associatedtype AnyCoordinator: Coordinator
    
    var state: Observable<AnyState> { get }
    var action: AnyObserver<AnyAction> { get }
    var coordinator: AnyCoordinator? { get set }
    
    func subscribe()
    func unsubscribe()
}
