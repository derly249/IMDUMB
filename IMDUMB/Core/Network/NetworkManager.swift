//
//  NetworkManager.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

import Alamofire

// SOLID: Single Responsibility Principle (SRP)
// NetworkManager solo maneja peticiones HTTP

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(
            endpoint: String,
            parameters: Parameters = [:],
            completion: @escaping (Result<T, Error>) -> Void
        ) {
            let url = NetworkConstants.baseURL + endpoint
            var params = parameters
            params["api_key"] = NetworkConstants.apiKey
            params["language"] = "es-MX"

            print("url : \(url)")
            print("params:  \(params)")
            
            AF.request(url, parameters: params)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
}
