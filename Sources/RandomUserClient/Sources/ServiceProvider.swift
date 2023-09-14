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
import Storage

final class ServiceProvider {
    
    let userService: UserService
    let bookmarkService: BookmarkService
    
    init(httpClient: HttpClient, storage: Storage) {
        self.userService = UserServiceProvider(httpClient: httpClient)
        self.bookmarkService = BookmarkServiceProvider(storage: storage)
    }
}
