//
//  RemoteMovieDataStore.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

import Foundation

// SOLID: SRP — solo obtiene datos remotos
final class RemoteMovieDataStore: MovieDataStoreProtocol {

    func fetchMovies(category: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        NetworkManager.shared.request(
            endpoint: "/movie/\(category)",
            completion: { (result: Result<MovieResponse, Error>) in
                switch result {
                case .success(let response):
                    print("print movie structure: \(category)")
                    print("print response: \(response)")
                    completion(.success(response.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}

struct CreditsResponse: Codable {
    let cast: [Actor]
}

extension RemoteMovieDataStore {
    func fetchActors(movieId: Int, completion: @escaping (Result<[Actor], Error>) -> Void) {
        NetworkManager.shared.request(
            endpoint: "/movie/\(movieId)/credits",
            completion: { (result: Result<CreditsResponse, Error>) in
                switch result {
                case .success(let response):
                    completion(.success(Array(response.cast.prefix(10))))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}
