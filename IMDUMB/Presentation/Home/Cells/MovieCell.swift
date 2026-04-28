//
//  MovieCell.swift
//  IMDUMB
//
//  Created by Derly on 26/04/26.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var ratingLabel: UILabel!

        override func awakeFromNib() {
            super.awakeFromNib()
            backgroundColor = .black
            titleLabel.textColor = .white
            ratingLabel.textColor = .yellow
            posterImageView.contentMode = .scaleAspectFill
            posterImageView.clipsToBounds = true
            posterImageView.layer.cornerRadius = 8
        }

        func configure(with movie: Movie) {
            titleLabel.text = movie.title
            ratingLabel.text = "⭐ \(String(format: "%.1f", movie.voteAverage))"
            loadImage(from: movie.posterPath)
        }

        private func loadImage(from path: String?) {
            guard let path = path else {
                posterImageView.backgroundColor = .darkGray
                return
            }
            let urlString = NetworkConstants.imageBaseURL + path
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            }.resume()
        }
    }
