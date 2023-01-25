//
//  HomePageViewModel.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/7/23.
//

import Foundation

class HomePageViewModel {
    
    //MARK: - Variables
    
    var delegate: DataChangeDelegate?
    private let dataManager: DataManager
    
    private var state: State {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    private var nextRace: Race?
    
    
    //MARK: - Initializers
    
    init() {
        self.state = .idle
        dataManager = DataManager()
    }
    
    
    //MARK: - Functions
    
    func getSecondsUntilNextRace() -> Int {
        
        if let nextRace = nextRace {
            return nextRace.getSecondsUntilNextRace()
        }
    
        return 0
    }
    
    func getNextRaceDate() -> String? {
        
        guard let nextRaceDate = nextRace?.date else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter.string(from: nextRaceDate)
    }
    
    func getNextRaceName() -> String? {
        
        if let nextRace = self.nextRace, let raceName = nextRace.raceName {
            return raceName
        }
        
        return nil
    }
    
    func getNextRaceLocation() -> String? {
        
        if let nextRace = self.nextRace, let locality = nextRace.circuit?.location?.locality, let country = nextRace.circuit?.location?.country {
            return "\(locality), \(country)"
        }
        
        return nil
    }
}

extension HomePageViewModel: HomePageViewModelDelegate {
    func fetchUpcomingRace() {
        dataManager.getUpcomingRace() { [weak self] result in
            
            switch result {
            case .success(let race):
                self?.nextRace = race
                self?.state = .success
            
            case .failure(let networkingError):
                self?.state = .error(networkingError)
            }
        }
    }
}
