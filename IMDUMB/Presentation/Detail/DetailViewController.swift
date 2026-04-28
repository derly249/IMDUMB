//
//  DetailViewController.swift
//  IMDUMB
//
//  Created by Derly on 27/04/26.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var actorsCollectionView: UICollectionView!
    @IBOutlet weak var recommendButton: UIButton!

    var presenter: DetailPresenter!
    private var imageURLs: [String] = []
    private var actors: [Actor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCarousel()
        setupActorsCollection()
        presenter.view = self
        presenter.viewDidLoad()
    }

    private func setupUI() {
        view.backgroundColor = .black
        if let contentView = scrollView.subviews.first {
            contentView.backgroundColor = .black
        }
        titleLabel.textColor = .white
        ratingLabel.textColor = .white
        overviewLabel.textColor = .lightGray
        overviewLabel.numberOfLines = 0

        recommendButton.backgroundColor = .systemYellow
        recommendButton.setTitleColor(.black, for: .normal)
        recommendButton.setTitle("Recomendar", for: .normal)
        recommendButton.layer.cornerRadius = 12
        recommendButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }

    private func setupCarousel() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width, height: 220)
        carouselCollectionView.collectionViewLayout = layout
        carouselCollectionView.isPagingEnabled = true
        carouselCollectionView.showsHorizontalScrollIndicator = false
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        carouselCollectionView.register(
            UINib(nibName: "CarouselCell", bundle: nil),
            forCellWithReuseIdentifier: "CarouselCell"
        )
    }

    private func setupActorsCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 40)
        actorsCollectionView.collectionViewLayout = layout
        actorsCollectionView.delegate = self
        actorsCollectionView.dataSource = self
        actorsCollectionView.backgroundColor = .black
        actorsCollectionView.register(
            UINib(nibName: "ActorCell", bundle: nil),
            forCellWithReuseIdentifier: "ActorCell"
        )
    }

    @IBAction func recommendTapped(_ sender: UIButton) {
       let modal = RecommendModalViewController(nibName: "RecommendModalViewController", bundle: nil)
        modal.movie = presenter.movie
        modal.modalPresentationStyle = .pageSheet
        if let sheet = modal.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(modal, animated: true)
    }
}

// MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol {

    func showLoading() {}
    func hideLoading() {}
    func showError(_ message: String) {}

    func showMovieDetail(_ movie: Movie) {
        titleLabel.text = movie.title
        ratingLabel.text = "⭐ \(String(format: "%.1f", movie.voteAverage))"
        overviewLabel.text = movie.overview
    }

    func showActors(_ actors: [Actor]) {
        self.actors = actors
        actorsCollectionView.reloadData()
    }

    func showImages(_ urls: [String]) {
        imageURLs = urls
        pageControl.numberOfPages = urls.count
        carouselCollectionView.reloadData()
    }
}

// MARK: - CollectionView
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == carouselCollectionView ? imageURLs.count : actors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == carouselCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselCell
            cell.configure(with: imageURLs[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCell", for: indexPath) as! ActorCell
            cell.configure(with: actors[indexPath.item])
            return cell
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(carouselCollectionView.contentOffset.x / view.frame.width)
        pageControl.currentPage = page
    }
}
