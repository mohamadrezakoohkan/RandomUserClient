//
//  Project.swift.swift
//  RandomUserClientManifests
//
//  Created by Mohammad reza on 9.09.2023.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let project = Graph.shared.storage.project(
    targets: [
        ModuleTarget(type: .main, dependencies: [.rxSwift], coreDataModels: [CoreDataModel("Storage.xcdatamodeld")]),
        ModuleTarget(type: .unitTests)
    ]
)
