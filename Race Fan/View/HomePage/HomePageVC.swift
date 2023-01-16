//
//  ViewController.swift
//  Race Fan
//
//  Created by Neal Siegrist on 12/30/22.
//

import UIKit

protocol DataChangeDelegate {
    func didUpdate(with state: State)
}

class HomePageVC: UIViewController {
    
    //MARK: - Variables
    
    let homepageView: HomePageView
    let viewModel: HomePageViewModel
    
    
    //MARK: Initializers
    
    init() {
        self.viewModel = HomePageViewModel()
        self.homepageView = HomePageView()
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchUpcomingRace()
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = homepageView
        
        setupNavigationController()
    }
    
    //MARK: - Functions
    
    private func setupNavigationController() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(profileClicked))
    }
    
    @objc private func profileClicked() {
        print("profile clicked")
    }
    
    func updateUI() {
        let secondsUntilNextRace = viewModel.getSecondsUntilNextRace()
        
        homepageView.raceCountdown.startTimer(withSecondsRemaining: secondsUntilNextRace)
        
        homepageView.nextRaceDate.text = viewModel.getNextRaceDate()
        homepageView.nextRaceTitle.text = viewModel.getNextRaceName()
        homepageView.locationLabel.text = viewModel.getNextRaceLocation()
        
        if secondsUntilNextRace <= 0 {
            homepageView.nextRaceBackground.isHidden = true
        } else {
            homepageView.nextRaceBackground.isHidden = false
        }
    }
    
    func displayErrorAlert() {
        homepageView.nextRaceBackground.isHidden = true
        let alertController = UIAlertController(title: nil, message: "Error retrieving schedule data. Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
}

extension HomePageVC: DataChangeDelegate {
    func didUpdate(with state: State) {
        switch state {
        case .success:
            print("In success state")
            
            DispatchQueue.main.async {
                self.updateUI()
            }
            
        case .error(let error):
            print("Error state occured: \(error)")
            
            //Show error message
            displayErrorAlert()
        case .idle:
            print("In idle state")
        case .loading:
            print("In loading state")
            //Show loading wheel
        }
    }
}
