//
//  DetailPresenter.swift
//  IMDUMB
//
//  Created by Derly on 27/04/26.
//

import Foundation

protocol DetailViewProtocol: ViewProtocol {
    func showMovieDetail(_ movie: Movie)
    func showActors(_ actors: [Actor])
    func showImages(_ urls: [String])
}

final class DetailPresenter: PresenterProtocol {

    weak var view: DetailViewProtocol?
    private(set) var movie: Movie
    private let dataStore = RemoteMovieDataStore()

    init(movie: Movie) {
        self.movie = movie
    }

    func viewDidLoad() {
        view?.showMovieDetail(movie)
        loadImages()
        loadActors()
    }

    private func loadImages() {
        var urls: [String] = []
        if let backdrop = movie.backdropPath {
            urls.append(NetworkConstants.imageBaseURL + backdrop)
        }
        if let poster = movie.posterPath {
            urls.append(NetworkConstants.imageBaseURL + poster)
        }
        view?.showImages(urls)
    }
    
    private func loadActors() {
        dataStore.fetchActors(movieId: movie.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let actors):
                    self?.view?.showActors(actors)
                case .failure:
                    self?.view?.showActors([])
                }
            }
        }
    }
}
