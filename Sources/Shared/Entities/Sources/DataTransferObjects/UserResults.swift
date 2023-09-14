//
//  UserResults.swift
//  Entities
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation

public struct UserResults: Codable {
    public let results: [User]
//    public let info: UserResultInfo
}

public struct UserResultInfo: Codable {
    public let seed: String
    public let results: Int
    public let page: Int
    public let version: String
}
