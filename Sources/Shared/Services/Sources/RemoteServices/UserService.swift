//
//  UserService.swift
//  Services
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import Networking
import Entities
import RxSwift

public protocol UserService {
    func getUsers(results: Int, page: Int) -> Single<UserResults>
}

public struct UserServiceProvider: UserService {
    
    private let baseURL: URL
    private let httpClient: HttpClient
    
    public init(httpClient: HttpClient, baseURL: URL = URL(string: "https://randomuser.me/api/")!) {
        self.httpClient = httpClient
        self.baseURL = baseURL
    }
    
    public func getUsers(results: Int, page: Int) -> Single<UserResults> {
        return httpClient.request(url: baseURL, decoder: UserDecoder(), params: [
            "results": "\(results)",
            "page": "\(page)"
        ])
    }
}
