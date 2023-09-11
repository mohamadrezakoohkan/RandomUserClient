//
//  Store.swift
//  CommonUtils
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import RxSwift

open class Store<AnyState: State, AnyAction: Action, AnyEffect: Effect, AnyCoordinator: Coordinator>: ViewStore {
    
    private let _state: BehaviorSubject<AnyState>
    public var state: Observable<AnyState> {
        return _state.asObservable()
    }
    
    private var actionDisposeBag = DisposeBag()
    private let _action: PublishSubject<AnyAction>
    public var action: AnyObserver<AnyAction> {
        return _action.asObserver()
    }
    
    public let schedular: ImmediateSchedulerType
    public weak var coordinator: AnyCoordinator?
    
    public init(initialState: AnyState, schedular: ImmediateSchedulerType = MainScheduler.asyncInstance) {
        self._state = BehaviorSubject<AnyState>.init(value: initialState)
        self._action = PublishSubject<AnyAction>.init()
        self.schedular = schedular
    }
    
    open func handle(
        _ action: AnyAction,
        currentState: AnyState,
        sendEffect: @escaping (AnyEffect) -> Void,
        sendAction: @escaping (AnyAction) -> Void
    ) {
        fatalError("handle(action:currentState:sendEffect:sendAction:) not implemented by subclass \(self)")
    }
    
    open func reduce(_ effect: AnyEffect, currentState: AnyState) -> AnyState {
        fatalError("reduce(effect:currentState:) not implemented by subclass \(self)")
    }
    
    private func dispatch(_ action: AnyAction) {
        do {
            let currentState = try _state.value()
            handle(action, currentState: currentState) { [weak self] effect in
                guard let self else { return }
                self._state.onNext(reduce(effect, currentState: currentState))
            } sendAction: { [weak self] action in
                guard let self else { return }
                self._action.onNext(action)
            }
        } catch {
            #if DEBUG
            print("dispatch(action:) failed to read state \(self)")
#endif
        }
    }
    
    public func subscribe() {
        _action
            .observe(on: schedular)
            .subscribe(onNext: { [weak self] action in
                self?.dispatch(action)
            }).disposed(by: actionDisposeBag)
    }
    
    public func unsubscribe() {
        actionDisposeBag = DisposeBag()
    }
}
