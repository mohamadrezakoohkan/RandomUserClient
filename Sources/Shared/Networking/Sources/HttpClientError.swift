//
//  HttpClientError.swift
//  Networking
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation

public enum HttpClientError: Error, LocalizedError {
    case invalidURL
    case requestFailed(URLResponse?)
    case invalidResponse
    case decodingFailed(Error)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NetworkingStrings.HttpClient.RequestError.invalidURL
        case .requestFailed:
            return NetworkingStrings.HttpClient.RequestError.requestFailed
        case .invalidResponse:
            return NetworkingStrings.HttpClient.RequestError.invalidResponse
        case .decodingFailed:
            return NetworkingStrings.HttpClient.RequestError.decodingFailed
        }
    }
}
