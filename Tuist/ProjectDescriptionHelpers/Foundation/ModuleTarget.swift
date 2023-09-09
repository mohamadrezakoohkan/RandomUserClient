//
//  ModuleTarget.swift
//  RandomUserClientManifests
//
//  Created by Mohammad reza on 9.09.2023.
//

import Foundation
import ProjectDescription

public enum ModuleTargetType {
    case main
    case example
    case unitTests
    
    public var extensionName: String {
        switch self {
        case .main:
            return ""
        case .example:
            return "Example"
        case .unitTests:
            return "UnitTests"
        }
    }
}

public struct ModuleTarget {
    
    public let type: ModuleTargetType
    public let dependencies: [TargetDependency]
    
    public init(type: ModuleTargetType, dependencies: [TargetDependency] = []) {
        self.type = type
        self.dependencies = dependencies
    }
}
