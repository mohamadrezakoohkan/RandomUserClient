//
//  Project.swift
//  RandomUserClientManifests
//
//  Created by Mohammad reza on 9.09.2023.
//

import Foundation
import ProjectDescriptionHelpers

let project = Graph.shared.intro.project(
    targets: [
        ModuleTarget(type: .main),
        ModuleTarget(type: .example),
        ModuleTarget(type: .unitTests)
    ]
)
