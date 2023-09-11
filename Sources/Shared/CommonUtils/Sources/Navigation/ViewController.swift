//
//  ViewController.swift
//  CommonUtils
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

open class ViewController<AnyViewStore: ViewStore>: UIViewController, ViewStoreContainer {
    
    public let disposeBag = DisposeBag()
    public let store: AnyViewStore
    public let schedular: ImmediateSchedulerType

    open var swipeBackEnabled: Bool {
        return true
    }
    
    public init(store: AnyViewStore, schedular: ImmediateSchedulerType = MainScheduler.asyncInstance) {
        self.store = store
        self.schedular = schedular
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("This controller cannot be initialized from Interface Builder. To initialize it via Interface Builder, change the store to be received lazily.")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setLayout(containerView: view)
        store.state
            .observe(on: schedular)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] state in
                self?.update(withState: state)
            }).disposed(by: disposeBag)
        
        update(fromStream: store.state
            .observe(on: schedular)
            .distinctUntilChanged()
        )
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setSwipeBack(enable: swipeBackEnabled)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setSwipeBack(enable: true)
        store.unsubscribe()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setFrame(safeAreaInsets: view.safeAreaInsets, containerView: view)
    }
    
    open func setLayout(containerView: UIView) {
        
    }
    
    open func setFrame(safeAreaInsets: UIEdgeInsets, containerView: UIView) {
        
    }
    
    open func update(withState state: AnyViewStore.AnyState) {
        
    }
    
    open func update(fromStream stateObservable: Observable<AnyViewStore.AnyState>) {
        
    }
    
    public func dispatch(action: AnyViewStore.AnyAction) {
        store.action.onNext(action)
    }
        
    private func setSwipeBack(enable: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = enable
    }
}
