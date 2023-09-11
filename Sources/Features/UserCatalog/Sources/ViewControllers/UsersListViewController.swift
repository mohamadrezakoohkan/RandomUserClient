//
//  UsersListViewController.swift
//  UserCatalog
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import UIKit
import CommonUtils
import CommonUI
import RxSwift

final class UsersListViewController: BaseViewController<UsersListStore> {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dispatch(action: .appear)
    }
    
    override func update(fromStream stateObservable: Observable<UsersListState>) {
        
    }
}
