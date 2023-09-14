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
    func getUsers(seed: String?, results: Int, page: Int) -> Single<UserResults>
    func getUsers(results: Int, page: Int) -> Single<UserResults>
}

public struct UserServiceProvider: UserService {
    
    private let baseURL: URL
    private let httpClient: HttpClient
    private let serializer: UserSerializer
    
    public init(
        httpClient: HttpClient,
        baseURL: URL = URL(string: "https://randomuser.me/api/")!,
        serializer: UserSerializer = UserSerializer()
    ) {
        self.httpClient = httpClient
        self.baseURL = baseURL
        self.serializer = serializer
    }
    
    public func getUsers(seed: String?, results: Int, page: Int) -> Single<UserResults> {
        return httpClient.request(url: baseURL, decoder: serializer.decoder, params: [
            "seed": seed,
            "results": "\(results)",
            "page": "\(page)"
        ])
    }
}

extension UserServiceProvider {
    public func getUsers(results: Int, page: Int) -> Single<UserResults> {
        getUsers(seed: nil, results: results, page: page)
    }
}
