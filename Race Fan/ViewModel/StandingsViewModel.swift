//
//  StandingsViewModel.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/19/23.
//

import Foundation

class StandingsViewModel {
    
    //MARK: - Variables
    
    var driverStandings: [DriverStandingItem]?
    var constructorStandings: [ConstructorStandingItem]?
    
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

extension StandingsViewModel: StandingsViewModelDelegate {
    func fetchStandings() {
        
        dataManager.getDriverStandings { [weak self] result in
            switch result {
            case .success(let driverStanding):
                print("Success case for driver standings: \(driverStanding.standings!.allObjects.count)")
                
                if let standings = driverStanding.standings?.allObjects as? [DriverStandingItem], !standings.isEmpty {
                    self?.driverStandings = standings.sorted(by: { driver1, driver2 in
                        return driver1.position < driver2.position
                    })
                    self?.state = .success
                    
                    return
                }
                
                self?.state = .error(NetworkingError.noData)
            case .failure(let networkingError):
                print("Error occured in driver standings: \(networkingError)")
            }
        }
        
        dataManager.getConstructorStandings { [weak self] result in
            switch result {
            case .success(let constructorStanding):
                print("Success case for constructor standings: \(constructorStanding.standings!.allObjects.count)")
                
                if let standings = constructorStanding.standings?.allObjects as? [ConstructorStandingItem], !standings.isEmpty {
                    self?.constructorStandings = standings.sorted(by: { constructor1, constructor2 in
                        return constructor1.position < constructor2.position
                    })
                    self?.state = .success
                    
                    return
                }
                
                self?.state = .error(NetworkingError.noData)
            case .failure(let networkingError):
                print("Error occured in contructor standings: \(networkingError)")
            }
        }
    }
}
