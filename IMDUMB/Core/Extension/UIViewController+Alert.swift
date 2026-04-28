//
//  UIViewController+Alert.swift
//  IMDUMB
//
//  Created by Derly on 28/04/26.
//

import UIKit

extension UIViewController {
    func showAlert(title: String = "Error", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func showSuccess(message: String) {
        showAlert(title: "¡Éxito! 🎉", message: message)
    }
}
