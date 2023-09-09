//
//  Project.swift.swift
//  RandomUserClientManifests
//
//  Created by Mohammad reza on 9.09.2023.
//

import Foundation
import ProjectDescriptionHelpers

let project = Graph.shared.entities.project(
    targets: [
        ModuleTarget(type: .main)
    ]
)
