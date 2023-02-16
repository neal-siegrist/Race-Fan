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
    
    var delegate: DataChangeDelegate? {
        didSet {
            self.delegate?.didUpdate(with: self.state)
        }
    }
    
    private var state: State {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    let dataManager: DataManager
    
    
    //MARK: - Initializers
    
    init() {
        self.state = .loading
        self.dataManager = DataManager.shared
        
        dataManager.addListener(forType: [.driver, .constructor], listener: self)
    }
    
    
    //MARK: - Functions
    
}


//MARK: - DataListener delegate

extension StandingsViewModel: DataListener {
    func dataIsUpdated(type: ListenerType) {
        var bothStandingsEmpty = true
        
        if let driverStandings = CoreDataService.shared.getDriverStandings(forYear: dataManager.getCurrentRacingSeasonYear()), !driverStandings.isEmpty {
            self.driverStandings = driverStandings.sorted(by: { driver1, driver2 in
                return driver1.position < driver2.position
            })
            self.state = .success
            bothStandingsEmpty = false
        }
        
        if let constructorStandings = CoreDataService.shared.getConstructorStandings(forYear: dataManager.getCurrentRacingSeasonYear()), !constructorStandings.isEmpty {
            self.constructorStandings = constructorStandings.sorted(by: { constructor1, constructor2 in
                return constructor1.position < constructor2.position
            })
            self.state = .success
            bothStandingsEmpty = false
        }
        
        if bothStandingsEmpty {
            self.state = .error(NetworkingError.noData)
        }
    }
    
    func errorOccured(error: Error) {
        self.state = .error(error)
    }
}
