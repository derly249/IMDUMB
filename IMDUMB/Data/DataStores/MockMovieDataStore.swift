//
//  MockMovieDataStore.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

import Foundation

final class MockMovieDataStore: MovieDataStoreProtocol {

    func fetchMovies(category: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let movies = [
            Movie(id: 1, title: "Movie Mock 1", overview: "Descripción 1",
                  posterPath: nil, voteAverage: 8.5, backdropPath: nil),
            Movie(id: 2, title: "Movie Mock 2", overview: "Descripción 2",
                  posterPath: nil, voteAverage: 7.0, backdropPath: nil)
        ]
        completion(.success(movies))
    }
}
