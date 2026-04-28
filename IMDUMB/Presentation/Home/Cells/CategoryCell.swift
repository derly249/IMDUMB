//
//  CategoryCell.swift
//  IMDUMB
//
//  Created by Derly on 26/04/26.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryTitleLabel: UILabel!
        @IBOutlet weak var tableView: UITableView!

        private var movies: [Movie] = []
        var onMovieSelected: ((Movie) -> Void)?

        override func awakeFromNib() {
            super.awakeFromNib()
            setupTableView()
            backgroundColor = .black
        }

        private func setupTableView() {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = .black
            tableView.separatorStyle = .none
            tableView.register(
                UINib(nibName: "MovieCell", bundle: nil),
                forCellReuseIdentifier: "MovieCell"
            )
        }

        func configure(with category: MovieCategory) {
            categoryTitleLabel.text = category.name
            movies = category.movies
            tableView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource & Delegate
    extension CategoryCell: UITableViewDataSource, UITableViewDelegate {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movies.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            cell.configure(with: movies[indexPath.row])
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            onMovieSelected?(movies[indexPath.row])
        }
        
    }
