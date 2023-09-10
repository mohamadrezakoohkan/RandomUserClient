//
//  BaseViewController.swift
//  CommonUtils
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

open class BaseViewController<AnyStore: Store<S, A, E>, S: State, A: Action, E: Effect>: UIViewController {
    
    public let disposeBag = DisposeBag()
    public var store: AnyStore!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        store.state.subscribe(onNext: { [weak self] state in
            self?.update(withState: state)
        }).disposed(by: disposeBag)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.subscribe()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        store.unsubscribe()
    }
    
    open func update(withState state: S) {
        
    }
    
    public func dispatch(action: A) {
        store.action.onNext(action)
    }
}
