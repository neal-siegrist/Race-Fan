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

extension TopConstructorStandingsViewModel: StandingsViewModelDelegate {
    func fetchStandings() {
        
        dataManager.getConstructorStandings { [weak self] result in
            switch result {
            case .success(let constructorStanding):
                print("Success case for constructor standings: \(constructorStanding.standings!.allObjects.count)")
                
                if let standings = constructorStanding.standings?.allObjects as? [ConstructorStandingItem], !standings.isEmpty, standings.count >= 3 {
                    let sortedStandings = standings.sorted(by: { constructor1, constructor2 in
                        return constructor1.position < constructor2.position
                    })
                    
                    self?.constructorStandings = Array(sortedStandings[0...2])
                    
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
