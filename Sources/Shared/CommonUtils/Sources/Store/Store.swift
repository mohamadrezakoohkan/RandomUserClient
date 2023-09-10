//
//  Store.swift
//  CommonUtils
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import RxSwift

open class Store<AnyState: State, AnyAction: Action, AnyEffect: Effect> {
    
    private let _state: BehaviorSubject<AnyState>
    internal var state: Observable<AnyState> {
        return _state.asObservable()
    }
    
    private var actionDisposeBag = DisposeBag()
    private let _action: PublishSubject<AnyAction>
    internal var action: AnyObserver<AnyAction> {
        return _action.asObserver()
    }
    
    public init(initialState: AnyState) {
        self._state = BehaviorSubject<AnyState>.init(value: initialState)
        self._action = PublishSubject<AnyAction>.init()
    }
    
    open func handle(_ action: AnyAction, currentState: AnyState, sendEffect: @escaping (AnyEffect) -> Void) {
        fatalError("handle(action:effect:) not implemented by children \(self)")
    }
    
    open func reduce(_ effect: AnyEffect, currentState: AnyState) -> AnyState {
        fatalError("reduce(effect:) not implemented by children \(self)")
    }
    
    private func dispatch(_ action: AnyAction) {
        do {
            let currentState = try _state.value()
            handle(action, currentState: currentState) { [weak self] effect in
                guard let self else { return }
                self._state.onNext(reduce(effect, currentState: currentState))
            }
        } catch {
            #if DEBUG
            print("dispatch(action:) failed to read state \(self)")
            #endif
        }
    }
    
    public func subscribe() {
        _action.subscribe(onNext: { [weak self] action in
            self?.dispatch(action)
        }).disposed(by: actionDisposeBag)
    }
    
    public func unsubscribe() {
        actionDisposeBag = DisposeBag()
    }
}
