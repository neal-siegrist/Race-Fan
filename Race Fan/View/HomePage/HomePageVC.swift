//
//  ViewController.swift
//  Race Fan
//
//  Created by Neal Siegrist on 12/30/22.
//

import UIKit

class HomePageVC: UIViewController {
    
    let homepageView = HomePageView()
    let viewModel = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        
        self.view = homepageView
        
        setupNavigationController()
        
        homepageView.raceCountdown.startTimer(withSecondsRemaining: 3605)
    }
    
    private func setupNavigationController() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(profileClicked))
    }
    
    @objc private func profileClicked() {
        print("profile clicked")
    }
}

