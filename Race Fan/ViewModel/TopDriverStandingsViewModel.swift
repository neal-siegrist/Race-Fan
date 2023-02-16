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
        
        dataManager.addListener(forType: [.driver], listener: self)
    }
}


//MARK: - DataListener delegate

extension TopDriverStandingsViewModel: DataListener {
    func dataIsUpdated(type: ListenerType) {
        if let standings = CoreDataService.shared.getDriverStandings(forYear: dataManager.getCurrentRacingSeasonYear()), !standings.isEmpty, standings.count >= 3 {
            let sortedStandings = standings.sorted(by: { driver1, driver2 in
                return driver1.position < driver2.position
            })
            
            self.driverStandings = Array(sortedStandings[0...2])
            
            self.state = .success
            
            return
        }
    }
    
    func errorOccured(error: Error) {
        self.state = .error(error)
    }
}
