//
//  HomePageViewModel.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/7/23.
//

import Foundation

class HomePageViewModel {
    
    //MARK: - Variables
    
    var delegate: DataChangeDelegate? {
        didSet {
            self.delegate?.didUpdate(with: self.state)
        }
    }
    private let dataManager: DataManager
    
    private var state: State {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    var nextRace: Race?
    
    
    //MARK: - Initializers
    
    init() {
        self.state = .loading
        dataManager = DataManager.shared
        
        dataManager.addListener(forType: [.schedule, .driver, .constructor], listener: self)
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
    
    private func extractFirstUpcomingRaceFromSchedule(schedule: [Race]) -> Race? {
        let currentDate = Date()
        
        for race in schedule {
            if let raceDate = race.date {
                if currentDate < raceDate { return race }
            }
        }
        
        return nil
    }
}


//MARK: - DataListener extension
extension HomePageViewModel: DataListener {
    func dataIsUpdated(type: ListenerType) {
        if case .schedule = type {
            if let schedule = CoreDataService.shared.getSchedule(forYear: dataManager.getCurrentRacingSeasonYear()) {
                self.nextRace = extractFirstUpcomingRaceFromSchedule(schedule: schedule)
                self.state = .success
            }
        }
    }
    
    func errorOccured(error: Error) {
        print("Error called on home page listenter. Error: \(error)")
    }
}
