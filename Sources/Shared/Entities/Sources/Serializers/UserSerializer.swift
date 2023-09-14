//
//  UserSerializer.swift
//  Entities
//
//  Created by Mohammad reza on 13.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation

public struct UserSerializer: Serializer {
    
    internal let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    public var encoder: JSONEncoder {
        let jsonEcoder = JSONEncoder()
        jsonEcoder.dateEncodingStrategy = .formatted(dateFormatter)
        return jsonEcoder
    }
    
    public var decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }

    public init() { }
}
