//
//  UserName.swift
//  Entities
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation

public struct Name: DataModel {
    public let title: String
    public let first: String
    public let last: String
    
    public var fullName: String {
        title + "." + first + " " + last
    }
}
