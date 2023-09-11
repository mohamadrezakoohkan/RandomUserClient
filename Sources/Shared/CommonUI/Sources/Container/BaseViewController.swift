//
//  BaseViewController.swift
//  CommonUI
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import UIKit
import CommonUtils

open class BaseViewController<AnyViewStore: ViewStore>: ViewController<AnyViewStore> {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CommonUIAsset.containerPrimary.color
    }
}
