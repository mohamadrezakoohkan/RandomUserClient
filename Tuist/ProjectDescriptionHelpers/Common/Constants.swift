//
//  Constants.swift
//  RandomUserClientManifests
//
//  Created by Mohammad reza on 9.09.2023.
//

import Foundation
import ProjectDescription

public struct Constants {
    
    private init() { }
    public static let shared = Constants()
    
    public let APP_NAME = "RandomUserClient"
    public let APP_DEPLOYMENT_TARGET = "14.0"
    public let APP_BUNDLE_ID = "$(APP_BUNDLE_ID)"
    public let APP_ORGANIZATION = "RandomUser"
    public let SOURCE_CODE_PATH_FROM_ROOT = "Sources/"
    public func DEFAULT_INFO_PLIST(
        name: String,
        bundleID: String,
        moduleType: ModuleType,
        extendingWith extraKeyValues: [String: InfoPlist.Value] = [:]
    ) -> [String: InfoPlist.Value]  {
        var plist: [String: InfoPlist.Value] = [
            "TUIST_GENERATED_NAME": .string(name),
            "TUIST_GENERATED_BUNDLE_ID": .string(bundleID),
            "TUIST_GENERATED_TYPE": .string(moduleType.rawValue)
        ]
        
        extraKeyValues.forEach { (key: String, value: InfoPlist.Value) in
            plist[key] = value
        }
        
        return plist
    }
}
