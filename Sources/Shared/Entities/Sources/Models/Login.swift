//
//  Login.swift
//  Entities
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation

public struct Login: Codable {
    public let uuid: String
    public let username: String
    public let password: String
    public let salt: String
    public let md5: String
    public let sha1: String
    public let sha256: String
}
