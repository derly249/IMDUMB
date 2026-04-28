//
//  MovieDataStore.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

protocol MovieDataStoreProtocol {
    func fetchMovies(category: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}
