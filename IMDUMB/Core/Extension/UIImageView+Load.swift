//
//  UIImageView+Load.swift
//  IMDUMB
//
//  Created by Derly on 28/04/26.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String?, placeholder: UIColor = .darkGray) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            backgroundColor = placeholder
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}
