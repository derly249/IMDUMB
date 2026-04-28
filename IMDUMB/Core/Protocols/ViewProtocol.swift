//
//  ViewProtocol.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

import Foundation

// SOLID: Interface Segregation Principle (ISP)
// Cada pantalla implementa solo lo que necesita

protocol ViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
}
