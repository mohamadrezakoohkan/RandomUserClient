//
//  StoreContainer.swift
//  CommonUtils
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation

public protocol ViewStoreContainer {
    
    associatedtype AnyViewStore: ViewStore
    
    var store: AnyViewStore { get }
}
