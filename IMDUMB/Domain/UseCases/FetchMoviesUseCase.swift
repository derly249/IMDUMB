//
//  FetchMoviesUseCase.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

import Foundation

final class FetchMoviesUseCase {

    private let repository: MovieRepository

    init(repository: MovieRepository = MovieRepository()) {
        self.repository = repository
    }

    func execute(category: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        repository.getMovies(category: category, completion: completion)
    }
}
