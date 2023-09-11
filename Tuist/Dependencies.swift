//
//  Dependencies.swift
//  Config
//
//  Created by Mohammad reza on 10.09.2023.
//

import Foundation
import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies([
        .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .exact("6.6.0"))
    ]),
    platforms: [
        .iOS
    ]
)
