//
//  MovieDataStore.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

// SOLID: Dependency Inversion Principle (DIP)
// Dependemos de abstracciones, no de implementaciones concretas

protocol MovieDataStoreProtocol {
    func fetchMovies(category: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}
