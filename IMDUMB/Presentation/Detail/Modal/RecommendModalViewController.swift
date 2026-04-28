//
//  RecommendModalViewController.swift
//  IMDUMB
//
//  Created by Derly on 27/04/26.
//

import UIKit

class RecommendModalViewController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboard()
    }

    private func setupUI() {
            view.backgroundColor = .black

            movieTitleLabel.font = .boldSystemFont(ofSize: 18)
            movieTitleLabel.textColor = .darkGray
            movieTitleLabel.numberOfLines = 0
            movieTitleLabel.text = movie?.title

            overviewLabel.font = .systemFont(ofSize: 14)
            overviewLabel.textColor = .darkGray
            overviewLabel.numberOfLines = 0
            overviewLabel.text = movie?.overview

            commentTextView.text = ""
            commentTextView.layer.borderColor = UIColor.lightGray.cgColor
            commentTextView.layer.borderWidth = 1
            commentTextView.layer.cornerRadius = 8
            commentTextView.font = .systemFont(ofSize: 14)

            confirmButton.backgroundColor = .systemYellow
            confirmButton.setTitle("Confirmar", for: .normal)
            confirmButton.setTitleColor(.black, for: .normal)
            confirmButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
            confirmButton.layer.cornerRadius = 12
        }

        // MARK: - Keyboard
        private func setupKeyboard() {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tap)
        }

        @objc private func keyboardWillShow(_ notification: Notification) {
            if let sheet = sheetPresentationController {
                sheet.animateChanges {
                    sheet.selectedDetentIdentifier = .large
                }
            }
        }

        @objc private func dismissKeyboard() {
            view.endEditing(true)
        }

        // MARK: - Actions
        @IBAction func confirmTapped(_ sender: UIButton) {
            guard let comment = commentTextView.text, !comment.isEmpty else {
                showAlert(message: "Por favor escribe un comentario")
                return
            }
            dismiss(animated: true) {
                // Toast/Alert de éxito desde el padre
            }
            showSuccessAlert()
        }

        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Aviso", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }

        private func showSuccessAlert() {
            let alert = UIAlertController(
                title: "¡Éxito! 🎉",
                message: "Tu recomendación fue enviada",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }

        deinit {
            NotificationCenter.default.removeObserver(self)
        }
}

