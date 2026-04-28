//
//  ViewProtocol.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

import Foundation

protocol ViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
}
