//
//  FetchMoviesUseCase.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

import Foundation

// SOLID: SRP — solo ejecuta la lógica de obtener películas

final class FetchMoviesUseCase {

    //private let repository: MovieRepository
    private var repository: MovieRepository = MovieRepository(dataStore: MockMovieDataStore())

    /*init(repository: MovieRepository = MovieRepository()) {
        self.repository = repository
    }*/

    func execute(category: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        repository.getMovies(category: category, completion: completion)
    }
}
