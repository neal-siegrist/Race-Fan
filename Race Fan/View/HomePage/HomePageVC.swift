//
//  ViewController.swift
//  Race Fan
//
//  Created by Neal Siegrist on 12/30/22.
//

import UIKit

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
        
        addNextRaceAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = homepageView
        
        setupNavigationController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchUpcomingRace()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Functions
    
    private func addNextRaceAction() {
        homepageView.nextRaceBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextRaceClicked)))
    }
    
    private func setupNavigationController() {
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25.0)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @objc private func profileClicked() {
        print("profile clicked")
    }
    
    @objc private func nextRaceClicked() {
        if let validRace = viewModel.nextRace {
            let raceDetailVC = RaceDetailVC(race: validRace)
            self.navigationController?.pushViewController(raceDetailVC, animated: true)
        }
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


//MARK: - DataChangeDelegate Conformance

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
