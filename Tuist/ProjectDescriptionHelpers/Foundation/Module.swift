//
//  Module.swift
//  RandomUserClientManifests
//
//  Created by Mohammad reza on 9.09.2023.
//

import Foundation
import ProjectDescription

public enum ModuleType: String {
    case launcher
    case feature
    case shared
}

public struct Module: Hashable {

    /// Type of module
    ///
    public let type: ModuleType
    
    /// Project name to be defined in Project.swift
    ///
    public let name: String
    
    /// Bundle ID for project to be defined in Project.swift
    ///
    public let bundleID: String
    
    /// Path to Project.swift
    ///
    public let projectPath: ProjectDescription.Path
    
    public init(
        type: ModuleType,
        name: String,
        bundleID: String? = nil,
        projectPath: ProjectDescription.Path? = nil
    ) {
        self.type = type
        self.name = name
        self.bundleID = bundleID ?? Self.automaticGeneratedBundleID(withType: type, name: name)
        self.projectPath = projectPath ?? Self.automaticGeneratedProjectPath(withType: type, name: name)
    }
    
    /// Path to .swift, .m, .h files of the project
    ///
    public func sourceCodePattern(forTarget target: String) -> SourceFilesList {
        if target == name {
            return "Sources/**/{*.swift,*.h,*.m}"
        } else {
            return "\(target)/**/{*.swift,*.h,*.m}"
        }
    }
    
    /// Path to any resources that you need to be copied into final binary bundle
    ///
    public func resourceFilePattern(forTarget target: String) -> ResourceFileElements {
        if target == name {
            return "Resources/**/{*.strings,*.xcassets,*.storyboard,*.xib,GoogleService-Info.plist,*.json,*.ttf,*.mp3}"
        } else {
            return "\(target)/**/{*.strings,*.xcassets,*.storyboard,*.xib,GoogleService-Info.plist,*.json,*.ttf,*.mp3}"
        }
    }
    
    /// Returns name for specific project target
    ///
    public func name(forTarget target: String) -> String {
        return isMainTarget(target) ? name : name + target
    }
    
    /// Returns bundleID for specific project target
    ///
    public func bundleID(forTarget target: String) -> String {
        return isMainTarget(target) ? bundleID : bundleID + target
    }
    
    /// Returns info.plist for specific project target
    ///
    public func infoPlist(forTarget target: String, isLauncher: Bool) -> InfoPlist {
        var extendingPlist: [String: InfoPlist.Value] = [:]
        if isLauncher {
            extendingPlist["UIApplicationSupportsIndirectInputEvents"] = .boolean(true)
            extendingPlist["UILaunchStoryboardName"] = .string("LaunchScreen")
        }
        return InfoPlist.extendingDefault(
            with: Constants.shared.DEFAULT_INFO_PLIST(
                name: name,
                bundleID: bundleID,
                moduleType: type,
                extendingWith: extendingPlist
            )
        )
    }
    
    
    public var targetDependency: TargetDependency {
        return TargetDependency.project(target: name, path: Path.relativeToRoot(projectPath.pathString))
    }
    
    public func project(
        projectName: String? = nil,
        infoPlist: InfoPlist? = nil,
        options: Project.Options = Project.Options.options(),
        settings newSettings: SettingsDictionary = SettingsDictionary(),
        targets: [ModuleTarget]
    ) -> ProjectDescription.Project {
        
        let newBaseSettings = baseSettings(fromSettings: newSettings, forProject: projectName ?? name)
        let excludingKeysFromDefaultSettings: Set<String> = Set(newBaseSettings.keys.map { $0 })
        let settings = Settings.settings(
            base: newBaseSettings,
            configurations: BuildConfiguration.allCases.map(\.projectConfiguration),
            defaultSettings: .recommended(excluding: excludingKeysFromDefaultSettings)
        )
        
        var sharedDependencies: [Dependency] = [.rxSwift, .rxCocoa]
        
        if type != .shared {
            sharedDependencies.append(contentsOf: [
                .commonUtils,
                .commonUI,
                .entities,
                .networking,
                .storage,
                .services
            ])
        }
        
        if type == .launcher {
            sharedDependencies.append(contentsOf: [
                .bookmarks,
                .intro,
                .tabBar,
                .userCatalog,
                .settings
            ])
        }
        
        return Project(
            name: projectName ?? name,
            organizationName: Constants.shared.APP_ORGANIZATION,
            options: options,
            settings: settings,
            targets: targets.map { moduleTarget -> Target in
                let targetExtension = moduleTarget.type.extensionName
                let targetName = targetExtension == "" ? name : targetExtension
                let targetDependencies = moduleTarget.dependencies.map { $0.targetDependency }
                var runnerName: String? = nil
                
                if let projectRunnerTarget = targets.first(where: { $0.type == .example }) {
                    runnerName = name(forTarget: projectRunnerTarget.type.extensionName)
                }
                
                return target(
                    targetName,
                    runnerTargetName: runnerName,
                    settings: settings,
                    dependencies: targetDependencies + sharedDependencies.map(\.targetDependency),
                    coreDataModels: moduleTarget.coreDataModels
                )
            }
        )
    }
    
    public func target(
        _ targetName: String,
        runnerTargetName: String?,
        settings: Settings,
        dependencies: [TargetDependency] = [],
        coreDataModels: [CoreDataModel]
    ) -> Target {
        let isLauncher = type == .launcher && isMainTarget(targetName)
        let isExample = targetName.contains(ModuleTargetType.example.extensionName)
        let isUnitTest = targetName.contains(ModuleTargetType.unitTests.extensionName)
        let internalDependencies: [TargetDependency] = !isMainTarget(targetName) ? [.target(name: name)] : []
        let testHostAppDependencies: [TargetDependency] = isUnitTest && (runnerTargetName != nil) ? [.target(name: runnerTargetName!)] : []

        return Target(
            name: name(forTarget: targetName),
            platform: .iOS,
            product: isLauncher || isExample ? .app : isUnitTest ? .unitTests : .framework,
            bundleId: bundleID(forTarget: targetName),
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist(forTarget: targetName, isLauncher: isLauncher),
            sources: sourceCodePattern(forTarget: targetName),
            resources: resourceFilePattern(forTarget: targetName),
            scripts: [],
            dependencies: dependencies + internalDependencies + testHostAppDependencies,
            settings: settings,
            coreDataModels: coreDataModels
        )
    }
    
    private var deploymentTarget: ProjectDescription.DeploymentTarget {
        return ProjectDescription.DeploymentTarget.iOS(
            targetVersion: Constants.shared.APP_DEPLOYMENT_TARGET,
            devices: [.iphone, .ipad, .mac]
        )
    }
    
    private func isMainTarget(_ targetName: String) -> Bool {
        targetName == name
    }
    
    private func baseSettings(
        fromSettings settings: SettingsDictionary = SettingsDictionary(),
        forProject projectName: String
    ) -> SettingsDictionary {
        if type == .launcher && projectName == Constants.shared.APP_NAME_VALUE {
            return settings.merging([
                "PRODUCT_NAME": .string("$(APP_NAME)"),
                "PRODUCT_BUNDLE_IDENTIFIER": .string("$(APP_BUNDLE_ID)"),
                "ASSETCATALOG_COMPILER_APPICON_NAME": .string("$(APP_ICON)"),
                "ONLY_ACTIVE_ARCH": .string("YES"),
                "ENABLE_TESTABILITY": .string("YES")
            ])
        } else {
            return settings
        }
    }
    
    public static func == (lhs: Module, rhs: Module) -> Bool {
        lhs.name == rhs.name &&
        lhs.type == rhs.type &&
        lhs.bundleID == rhs.bundleID &&
        lhs.projectPath.pathString == rhs.projectPath.pathString
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(type)
        hasher.combine(bundleID)
        hasher.combine(projectPath)
    }
}

fileprivate extension Module {
    
    static func automaticGeneratedBundleID(withType type: ModuleType, name: String) -> String {
        if type == .launcher {
            return Constants.shared.APP_BUNDLE_ID
        } else {
            return "\(Constants.shared.APP_BUNDLE_ID).\(name)"
        }
    }
    
    static func automaticGeneratedProjectPath(withType type: ModuleType, name: String) -> ProjectDescription.Path {
        switch type {
        case .launcher:
            return "\(Constants.shared.SOURCE_CODE_PATH_FROM_ROOT)\(name)"
        case .shared:
            return "\(Constants.shared.SOURCE_CODE_PATH_FROM_ROOT)Shared/\(name)"
        case .feature:
            return "\(Constants.shared.SOURCE_CODE_PATH_FROM_ROOT)Features/\(name)"
        }
    }
}
