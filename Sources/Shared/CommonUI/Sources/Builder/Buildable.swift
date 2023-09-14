//
//  Buildable.swift
//  CommonUI
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import UIKit

/// Building UIViews with builder design pattern allowing different variations
///
public protocol Buildable: UIView {

    @discardableResult
    static func build<View: UIView>(_ modify: ((View) -> Void)?) -> View

    func createChain() -> Self
}

extension UIView: Buildable {

    @discardableResult
    public static func build<View: UIView>(_ modify: ((View) -> Void)? = nil) -> View {
        let view = View.init()
        modify?(view)
        return view
    }

    public func createChain() -> Self {
        return self
    }
}
