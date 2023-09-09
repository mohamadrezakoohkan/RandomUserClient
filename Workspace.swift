//
//  Workspace.swift
//  RandomUserClientManifests
//
//  Created by Mohammad reza on 9.09.2023.
//

import ProjectDescription
import ProjectDescriptionHelpers

let MAIN_PROJECT_NAME = Constants.shared.APP_NAME_VALUE
let WORKSPACE_NAME = MAIN_PROJECT_NAME
let SCHEME_NAME = "Bootstrap"
let MODULES = Graph.shared.allModules

let targets = MODULES.map { module -> TargetReference in
    return TargetReference(
        projectPath: module.projectPath,
        target: module.name
    )
}

let testTargets: [TestableTarget] = targets.map { target -> TestableTarget in
    let targetName = target.targetName + ModuleTargetType.unitTests.extensionName
    let targetPath = target.projectPath!
    let targetRef = TargetReference.project(path: targetPath, target: targetName)
    return TestableTarget(
        target: targetRef,
        parallelizable: true,
        randomExecutionOrdering: true
    )
}

let scheme = Scheme(
    name: SCHEME_NAME,
    shared: true,
    buildAction: .buildAction(
        targets: targets
    ),
    testAction: .targets(
        testTargets,
        configuration: BuildConfiguration.debug.configName,
        options: .options(
            coverage: true,
            codeCoverageTargets: targets
        ),
        diagnosticsOptions: [.mainThreadChecker, .performanceAntipatternChecker]
    ),
    runAction: .runAction(
        configuration: BuildConfiguration.debug.configName,
        executable: targets.first(where: { $0.targetName == MAIN_PROJECT_NAME }),
        diagnosticsOptions: [.mainThreadChecker, .performanceAntipatternChecker]
    ),
    archiveAction: .archiveAction(
        configuration: BuildConfiguration.release.configName,
        revealArchiveInOrganizer: true
    ),
    profileAction: .profileAction(
        configuration: BuildConfiguration.release.configName,
        executable: targets.first(where: { $0.targetName == MAIN_PROJECT_NAME })
    ),
    analyzeAction: .analyzeAction(
        configuration: BuildConfiguration.debug.configName
    )
)

let workspace = Workspace(
    name: WORKSPACE_NAME,
    projects: MODULES.map(\.projectPath),
    schemes: [scheme],
    additionalFiles: [],
    generationOptions: Workspace.GenerationOptions.options(
        renderMarkdownReadme: true
    )
)
