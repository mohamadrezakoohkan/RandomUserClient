//
//  ServiceProvider.swift
//  RandomUserClient
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import Services
import Networking

final class ServiceProvider {
    
    let userService: UserService
    
    init(httpClient: HttpClient) {
        self.userService = UserServiceProvider(httpClient: httpClient)
    }
}
