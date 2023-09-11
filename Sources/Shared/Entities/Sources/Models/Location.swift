//
//  Location.swift
//  Entities
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation

public struct Location: Codable {
    public let street: Street
    public let city: String
    public let state: String
    public let country: String
    public let postcode: Int
    public let coordinates: Coordinate
    public let timezone: Timezone
}
