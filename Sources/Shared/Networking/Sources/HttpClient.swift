//
//  HttpClient.swift
//  Networking
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import RxSwift

public struct HttpClient {
    
    private let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(
        url: URL,
        decoder: JSONDecoder = JSONDecoder(),
        params: [String: String?] = [:]
    ) -> Single<T> {
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return Single.error(HttpClientError.invalidURL)
        }
        
        var queryItems = [URLQueryItem]()
        for param in params {
            if param.value != nil {
                queryItems.append(URLQueryItem(name: param.key, value: param.value))
            }
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            return Single.error(HttpClientError.invalidURL)
        }
        
        return Single.create { single in
        
            let task = self.session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    single(.failure(error))
                    return
                }
                
                guard let data = data else {
                    single(.failure(HttpClientError.requestFailed(response)))
                    return
                }
                
                do {
                    single(.success(try decoder.decode(T.self, from: data)))
                } catch let decodingError {
                    single(.failure(HttpClientError.decodingFailed(decodingError)))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
