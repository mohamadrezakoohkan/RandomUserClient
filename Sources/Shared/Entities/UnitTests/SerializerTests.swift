//
//  SerializerTests.swift
//  EntitiesUnitTests
//
//  Created by Mohammad reza on 14.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import XCTest
@testable import Entities

final class SerializerTests: XCTestCase {
    
   
    let userJson = """
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
    
    func testUserDecoding() throws {
        let serializer = UserSerializer()
        let user = try serializer.decoder.decode(User.self, from: userJson.data(using: .utf8)!)
        XCTAssertEqual(user.name.first, "Draško")
        XCTAssertEqual(user.dob.date, serializer.dateFormatter.date(from: "1967-11-12T12:32:36.683Z")!)
        XCTAssertEqual(user.registered.date, serializer.dateFormatter.date(from: "2004-05-10T14:37:26.030Z")!)
        XCTAssertEqual(user.location.postcode.intValue, 57160)
        XCTAssertNil(user.location.postcode.stringValue)
    }
    
    func testUserEncoding() throws {
        let serializer = UserSerializer()
        let user = try serializer.decoder.decode(User.self, from: userJson.data(using: .utf8)!)
        XCTAssertEqual(user.name.first, "Draško")
        XCTAssertEqual(user.dob.date, serializer.dateFormatter.date(from: "1967-11-12T12:32:36.683Z")!)
        XCTAssertEqual(user.registered.date, serializer.dateFormatter.date(from: "2004-05-10T14:37:26.030Z")!)
        XCTAssertEqual(user.location.postcode.intValue, 57160)
        XCTAssertNil(user.location.postcode.stringValue)
    }
}
