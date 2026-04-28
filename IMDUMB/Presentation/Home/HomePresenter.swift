//
//  HomePresenter.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

import Foundation

protocol HomeViewProtocol: ViewProtocol {
    func reloadData()
}

final class HomePresenter: PresenterProtocol {

    weak var view: HomeViewProtocol?
    private let fetchMoviesUseCase: FetchMoviesUseCase
    
    //private var fetchMoviesUseCase = FetchMoviesUseCase(repository: MovieRepository(dataStore: MockMovieDataStore()))
    
    private(set) var categories: [MovieCategory] = []

    private let categoryNames = ["popular", "top_rated", "upcoming", "now_playing"]
    private let categoryTitles = ["Popular", "Mejor Valoradas", "Próximas", "En Cines"]

    init(fetchMoviesUseCase: FetchMoviesUseCase = FetchMoviesUseCase()) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }

    func viewDidLoad() {
        view?.showLoading()
        categories = categoryTitles.map { MovieCategory(name: $0, movies: []) }
        
        let group = DispatchGroup()

        for (index, category) in categoryNames.enumerated() {
            group.enter()
            fetchMoviesUseCase.execute(category: category) { [weak self] result in
                defer { group.leave() }
                switch result {
                case .success(let movies):
                    self?.categories[index].movies = movies
                case .failure:
                    break
                }
            }
        }

        group.notify(queue: .main) { [weak self] in
            self?.view?.hideLoading()
            self?.view?.reloadData()
        }
    }
}
