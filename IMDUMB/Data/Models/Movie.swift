//
//  Movie.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
    }
}

struct MovieCategory {
    let name: String
    var movies: [Movie]
}

struct Actor: Codable {
    let name: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
    }
}
