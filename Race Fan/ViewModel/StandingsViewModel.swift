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
    //var constructorStandings: [ConstructorStandingItem]?
    
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
        
        dataManager.getDriverStandings { result in
            switch result {
            case .success(let driverStandings):
                print("Success case: \(driverStandings.standings!.allObjects.count)")
                
            case .failure(let networkingError):
                print("Error occured: \(networkingError)")
            }
        }
        
//        dataManager.getConstructorStandings { result in
//            switch result {
//            case .success(let constructorStandings):
//                print("Success case: \(constructorStandings)")
//
//            case .failure(let networkingError):
//                print("Error occured: \(networkingError)")
//            }
//        }
    }
}
