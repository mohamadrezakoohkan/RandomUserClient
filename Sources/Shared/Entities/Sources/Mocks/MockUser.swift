//
//  MockUser.swift
//  Entities
//
//  Created by Mohammad reza on 14.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation

public extension User {
    
    static func mock() throws -> User {
        let json = """
    {
      "gender": "male",
      "name": {
        "title": "Mr",
        "first": "Draško",
        "last": "Rukavina"
      },
      "location": {
        "street": {
          "number": 7834,
          "name": "Brnjačka"
        },
        "city": "Bački Petrovac",
        "state": "Central Banat",
        "country": "Serbia",
        "postcode": 57160,
        "coordinates": {
          "latitude": "58.9184",
          "longitude": "-63.1589"
        },
        "timezone": {
          "offset": "-12:00",
          "description": "Eniwetok, Kwajalein"
        }
      },
      "email": "drasko.rukavina@example.com",
      "login": {
        "uuid": "4a0c1118-8fbf-4cfa-adf6-c610cc624b0d",
        "username": "yellowgorilla822",
        "password": "stones",
        "salt": "F9S9U9Qx",
        "md5": "4743bcd43fb929db7abd98ebf46ae8fa",
        "sha1": "6a0d9e270950c72ad642d172e8d622eecea0da2a",
        "sha256": "176628be2ce6edc044955af316a39a79603a6129f330d6c2ce9701aea488aab0"
      },
      "dob": {
        "date": "1967-11-12T12:32:36.683Z",
        "age": 55
      },
      "registered": {
        "date": "2004-05-10T14:37:26.030Z",
        "age": 19
      },
      "phone": "037-4127-085",
      "cell": "066-3716-426",
      "id": {
        "name": "SID",
        "value": "630142408"
      },
      "picture": {
        "large": "https://randomuser.me/api/portraits/men/2.jpg",
        "medium": "https://randomuser.me/api/portraits/med/men/2.jpg",
        "thumbnail": "https://randomuser.me/api/portraits/thumb/men/2.jpg"
      },
      "nat": "RS"
    }
    """
        
        return try UserSerializer().decoder.decode(User.self, from: json.data(using: .utf8)!)
    }
}
