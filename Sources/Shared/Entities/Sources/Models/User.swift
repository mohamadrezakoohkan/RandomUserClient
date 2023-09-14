//
//  User.swift
//  Entities
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation

public struct UserID: DataModel {
    public let name: String?
    public let value: String?
}

public struct User: DataModel {
    public let gender: Gender
    public let name: Name
    public let location: Location
    public let email: String
    public let login: Login
    public let dob: DateOfBirth
    public let registered: Registration
    public let phone: String
    public let cell: String
    public let id: UserID
    public let picture: Picture
    public let nat: String
}
