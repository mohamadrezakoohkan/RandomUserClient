//
//  BuildConfiguration.swift
//  RandomUserClientManifests
//
//  Created by Mohammad reza on 9.09.2023.
//

import Foundation
import ProjectDescription

public enum BuildConfiguration: String, CaseIterable {
    case debug = "Debug"
    case release = "Release"
    
    public var configName: ProjectDescription.ConfigurationName {
        return .configuration(rawValue)
    }
    
    public var projectConfiguration: ProjectDescription.Configuration {
        let xcconfigPath = Path.relativeToRoot("Configurations/\(rawValue).xcconfig")
        switch self {
        case .debug:
            return .debug(name: configName, xcconfig: xcconfigPath)
        case .release:
            return .release(name: configName, xcconfig: xcconfigPath)
        }
    }
}
