//
//  Location.swift
//  Entities
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation

public struct Location: DataModel {
    public let street: Street
    public let city: String
    public let state: String
    public let country: String
    public let postcode: PostCode
    public let coordinates: Coordinate
    public let timezone: Timezone
    
    public struct PostCode: Hashable {
        let intValue: Int?
        let stringValue: String?
    }
    
    private enum CodingKeys: String, CodingKey {
         case street
         case city
         case state
         case country
         case postcode
         case coordinates
         case timezone
     }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decode(Street.self, forKey: .street)
        self.city = try container.decode(String.self, forKey: .city)
        self.state = try container.decode(String.self, forKey: .state)
        self.country = try container.decode(String.self, forKey: .country)
        self.coordinates = try container.decode(Coordinate.self, forKey: .coordinates)
        self.timezone = try container.decode(Timezone.self, forKey: .timezone)
        self.postcode = PostCode(
            intValue: try? container.decode(Int.self, forKey: .postcode),
            stringValue: try? container.decode(String.self, forKey: .postcode)
        )
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(street, forKey: .street)
        try container.encode(city, forKey: .city)
        try container.encode(state, forKey: .state)
        try container.encode(country, forKey: .country)
        try container.encode(coordinates, forKey: .coordinates)
        try container.encode(timezone, forKey: .timezone)
        if let intValue = postcode.intValue {
            try container.encode(intValue, forKey: .postcode)
        } else if let stringValue = postcode.stringValue {
            try container.encode(stringValue, forKey: .postcode)
        }
    }
}
