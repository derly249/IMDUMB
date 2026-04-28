//
//  HomeViewController.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let presenter = HomePresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        presenter.view = self
        presenter.viewDidLoad()
    }

    private func setupUI() {
        title = "IMDUMB"
        view.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        //navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        collectionView.register(
            UINib(nibName: "CategoryCell", bundle: nil),
            forCellWithReuseIdentifier: "CategoryCell"
        )
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: 280)
        layout.minimumLineSpacing = 16
        collectionView.collectionViewLayout = layout
    }
}

extension HomeViewController: HomeViewProtocol {

    func showLoading() {
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func reloadData() {
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.configure(with: presenter.categories[indexPath.item])
        
        cell.onMovieSelected = { [weak self] movie in
            let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
            detailVC.presenter = DetailPresenter(movie: movie)
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        return cell
    }
}
