//
//  StartupViewController.swift
//  Intro
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import CommonUtils
import CommonUI

final class StartupViewController: BaseViewController<StartupStore> {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dispatch(action: .appear)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dispatch(action: .disappear)
    }
    
    override func update(withState state: StartupState) {
        
    }
}
