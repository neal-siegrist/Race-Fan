//
//  TopConstructorStandingsViewModel.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/28/23.
//

import Foundation

class TopConstructorStandingsViewModel {
    
    //MARK: - Variables
    
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
        
        dataManager.addListener(forType: [.constructor], listener: self)
    }
}


//MARK: - DataListener extension

extension TopConstructorStandingsViewModel: DataListener {
    func dataIsUpdated(type: ListenerType) {
        switch type {
        case .constructor:
            if let standings = CoreDataService.shared.getConstructorStandings(forYear: dataManager.getCurrentRacingSeasonYear()), !standings.isEmpty, standings.count >= 3 {
                
                let sortedStandings = standings.sorted(by: { constructor1, constructor2 in
                    return constructor1.position < constructor2.position
                })
                
                self.constructorStandings = Array(sortedStandings[0...2])
                self.state = .success
    
                return
            }
        default:
            break
        }
        
        
        self.state = .error(NetworkingError.noData)
    }
    
    func errorOccured(error: Error) {
        self.state = .error(error)
    }
}
