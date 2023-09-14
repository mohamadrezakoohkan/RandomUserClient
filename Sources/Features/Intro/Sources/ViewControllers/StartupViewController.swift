//
//  StartupViewController.swift
//  Intro
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import UIKit
import CommonUtils
import CommonUI
import RxSwift

final class StartupViewController: BaseViewController<StartupStore> {
    
    private let spinnerLoadingView = SpinnerLoadingView()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dispatch(action: .appear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dispatch(action: .disappear)
    }
    
    override func setLayout(containerView: UIView) {
        spinnerLoadingView
            .disableAutoresizingMaskIntoConstraints()
            .add(toView: containerView)
            .horizontal(toConstraint: containerView.centerXAnchor)
            .vertical(toConstraint: containerView.centerYAnchor)
    }
        
    override func update(fromStream stateObservable: Observable<StartupState>) {
        stateObservable
            .map(\.isLoading)
            .distinctUntilChanged()
            .bind(to: spinnerLoadingView.rx.isLoading)
            .disposed(by: disposeBag)
    }
}
