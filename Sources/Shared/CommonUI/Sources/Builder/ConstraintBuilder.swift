//
//  ConstraintBuilder.swift
//  CommonUI
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//


import UIKit

public protocol ConstraintBuilder: Buildable {
    
    @discardableResult
    func disableAutoresizingMaskIntoConstraints() -> Self
    
    @discardableResult
    func add(toView containerView: UIView) -> Self
    
    @discardableResult
    func top(toConstraint constraint: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat, priority: UILayoutPriority ) -> Self
    
    @discardableResult
    func bottom(toConstraint constraint: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat, priority: UILayoutPriority) -> Self
    
    @discardableResult
    func leading(toConstraint constraint: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat, priority: UILayoutPriority ) -> Self
    
    @discardableResult
    func trailing(toConstraint constraint: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat, priority: UILayoutPriority ) -> Self
    
    @discardableResult
    func vertical(toConstraint constraint: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat, priority: UILayoutPriority) -> Self
    
    @discardableResult
    func horizontal(toConstraint constraint: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat, priority: UILayoutPriority) -> Self
    
    @discardableResult
    func height(toConstraint constraint: NSLayoutAnchor<NSLayoutDimension>?, constant: CGFloat, priority: UILayoutPriority ) -> Self
    
    @discardableResult
    func width(toConstraint constraint: NSLayoutAnchor<NSLayoutDimension>?, constant: CGFloat, priority: UILayoutPriority) -> Self
}

public extension ConstraintBuilder where Self: UIView {
    
    @discardableResult
    func disableAutoresizingMaskIntoConstraints() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return createChain()
    }
    
    @discardableResult
    func add(toView containerView: UIView) -> Self {
        containerView.addSubview(self)
        return createChain()
    }
    
    @discardableResult
    func top(toConstraint constraint: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero, priority: UILayoutPriority = .required) -> Self {
        let anchor = topAnchor.constraint(equalTo: constraint, constant: constant)
        anchor.isActive = true
        anchor.priority = priority
        return createChain()
    }
    
    @discardableResult
    func bottom(toConstraint constraint: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero, priority: UILayoutPriority = .required) -> Self {
        let anchor = bottomAnchor.constraint(equalTo: constraint, constant: constant)
        anchor.isActive = true
        anchor.priority = priority
        return createChain()
    }
    
    @discardableResult
    func leading(toConstraint constraint: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero, priority: UILayoutPriority = .required) -> Self {
        let anchor = leadingAnchor.constraint(equalTo: constraint, constant: constant)
        anchor.isActive = true
        anchor.priority = priority
        return createChain()
    }
    
    @discardableResult
    func trailing(toConstraint constraint: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero, priority: UILayoutPriority = .required) -> Self {
        let anchor = trailingAnchor.constraint(equalTo: constraint, constant: constant)
        anchor.isActive = true
        anchor.priority = priority
        return createChain()
    }
    
    @discardableResult
    func vertical(toConstraint constraint: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero, priority: UILayoutPriority = .required) -> Self {
        let anchor = centerYAnchor.constraint(equalTo: constraint, constant: constant)
        anchor.isActive = true
        anchor.priority = priority
        return createChain()
    }
    
    @discardableResult
    func horizontal(toConstraint constraint: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero, priority: UILayoutPriority = .required) -> Self {
        let anchor = centerXAnchor.constraint(equalTo: constraint, constant: constant)
        anchor.isActive = true
        anchor.priority = priority
        return createChain()
    }
    
    @discardableResult
    func height(toConstraint constraint: NSLayoutAnchor<NSLayoutDimension>? = nil, constant: CGFloat = .zero, priority: UILayoutPriority = .required) -> Self {
        let anchor = constraint != nil
        ? heightAnchor.constraint(equalTo: constraint!, constant: constant)
        : heightAnchor.constraint(equalToConstant: constant)
        anchor.isActive = true
        anchor.priority = priority
        return createChain()
    }
    
    @discardableResult
    func width(toConstraint constraint: NSLayoutAnchor<NSLayoutDimension>? = nil, constant: CGFloat = .zero, priority: UILayoutPriority = .required) -> Self {
        let anchor = constraint != nil
        ? widthAnchor.constraint(equalTo: constraint!, constant: constant)
        : widthAnchor.constraint(equalToConstant: constant)
        anchor.isActive = true
        anchor.priority = priority
        return createChain()
    }
}

extension UIView: ConstraintBuilder { }
