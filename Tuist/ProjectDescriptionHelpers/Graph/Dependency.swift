//
//  Dependency.swift
//  Config
//
//  Created by Mohammad reza on 10.09.2023.
//

import Foundation
import ProjectDescription

public enum Dependency: CaseIterable {
    
    case rxSwift
    case rxCocoa
    
    public var targetDependency: TargetDependency {
        switch self {
        case .rxSwift:
            return TargetDependency.external(name: "RxSwift")
        case .rxCocoa:
            return TargetDependency.external(name: "RxCocoa")
        }
    }
}
