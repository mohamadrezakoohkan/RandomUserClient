//
//  Serializer.swift
//  Entities
//
//  Created by Mohammad reza on 13.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation

public protocol Serializer {
    
    var econder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
    
    func jsonObject<Object: Encodable>(_ object: Object) -> [String: Any]?
    func jsonString<Object: Encodable>(_ object: Object) -> String?
}

public extension Serializer {
    
    var encoder: JSONEncoder {
        JSONEncoder()
    }
    
    var decoder: JSONDecoder {
        JSONDecoder()
    }
    
    func jsonObject<Object: Encodable>(_ object: Object) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: encoder.encode(object)) as? [String: Any]
        } catch {
            print(error)
            return nil
        }
    }
    
    func jsonString<Object: Encodable>(_ object: Object) -> String? {
        do {
            return try String(data: encoder.encode(object), encoding: .utf8)
        } catch {
            print(error)
            return nil
        }
    }
}
