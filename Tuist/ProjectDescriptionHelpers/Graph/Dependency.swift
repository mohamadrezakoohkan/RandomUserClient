//
//  Dependency.swift
//  Config
//
//  Created by Mohammad reza on 10.09.2023.
//

import Foundation
import ProjectDescription

public enum Dependency: CaseIterable {
    
    case entities
    case networking
    case storage
    case services
    case commonUI
    case commonUtils
    
    case intro
    case tabBar
    case userCatalog
    case bookmarks
    case settings
    
    case rxSwift
    case rxCocoa
    
    public var targetDependency: TargetDependency {
        switch self {
        case .entities:
            return Graph.shared.entities.targetDependency
        case .networking:
            return Graph.shared.networking.targetDependency
        case .storage:
            return Graph.shared.storage.targetDependency
        case .services:
            return Graph.shared.services.targetDependency
        case .commonUI:
            return Graph.shared.commonUI.targetDependency
        case .commonUtils:
            return Graph.shared.commonUtils.targetDependency
        case .intro:
            return Graph.shared.intro.targetDependency
        case .tabBar:
            return Graph.shared.tabBar.targetDependency
        case .userCatalog:
            return Graph.shared.userCatalog.targetDependency
        case .bookmarks:
            return Graph.shared.bookmarks.targetDependency
        case .settings:
            return Graph.shared.settings.targetDependency
        case .rxSwift:
            return TargetDependency.external(name: "RxSwift")
        case .rxCocoa:
            return TargetDependency.external(name: "RxCocoa")
        }
    }
}
