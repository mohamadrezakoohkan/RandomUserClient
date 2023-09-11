//
//  UserDecoder.swift
//  Entities
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation

public final class UserDecoder: JSONDecoder {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    public override init() {
        super.init()
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
