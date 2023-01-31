//
//  TopDriverStandingsViewModel.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/28/23.
//

import Foundation

class TopDriverStandingsViewModel {
    
    //MARK: - Variables
    
    var driverStandings: [DriverStandingItem]?
    
    var delegate: DataChangeDelegate?
    
    private var state: State {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    let dataManager: DataManager
    
    
    //MARK: - Initializers
    
    init() {
        self.state = .idle
        self.dataManager = DataManager()
    }
    
    
    //MARK: - Functions
    
}

extension TopDriverStandingsViewModel: StandingsViewModelDelegate {
    func fetchStandings() {
        
        dataManager.getDriverStandings { [weak self] result in
            print("getting driver standings for front page")
            switch result {
            case .success(let driverStanding):
                print("Success case for driver standings: \(driverStanding.standings!.allObjects.count)")
                
                if let standings = driverStanding.standings?.allObjects as? [DriverStandingItem], !standings.isEmpty, standings.count >= 3 {
                    let sortedStandings = standings.sorted(by: { driver1, driver2 in
                        return driver1.position < driver2.position
                    })
                    
                    self?.driverStandings = Array(sortedStandings[0...2])
                
                    self?.state = .success
                    
                    return
                }
                
                self?.state = .error(NetworkingError.noData)
            case .failure(let networkingError):
                print("Error occured in driver standings: \(networkingError)")
            }
        }
    }
}
