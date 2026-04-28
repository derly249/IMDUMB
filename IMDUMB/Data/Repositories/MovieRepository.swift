//
//  MovieRepository.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

import Foundation

final class MovieRepository {

    private let dataStore: MovieDataStoreProtocol

    init(dataStore: MovieDataStoreProtocol = RemoteMovieDataStore()) {
        self.dataStore = dataStore
    }

    func getMovies(category: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        dataStore.fetchMovies(category: category, completion: completion)
    }
}
