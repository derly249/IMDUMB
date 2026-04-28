//
//  SplashViewController.swift
//  IMDUMB
//
//  Created by Derly on 25/04/26.
//

import UIKit
import FirebaseRemoteConfig

class SplashViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFirebaseConfig()
        view.backgroundColor = .black
        titleLabel.text = "IMDUMB"
        titleLabel.textColor = .white
        activityIndicator.startAnimating()
        print("Ambiente: \(AppEnvironment.name)")

    }
    
    private func loadFirebaseConfig() {
        activityIndicator.startAnimating()
        
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.setDefaults(["app_title": "IMDUMB" as NSObject])
        
        remoteConfig.fetchAndActivate { [weak self] status, error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                let title = remoteConfig["app_title"].stringValue
                self?.titleLabel.text = title.isEmpty ? "IMDUMB" : title
                self?.goToHome()
            }
        }
    }
    private func goToHome() {
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: homeVC)
        navController.modalTransitionStyle = .crossDissolve
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
}
