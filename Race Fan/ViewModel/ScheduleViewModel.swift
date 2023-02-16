//
//  ScheduleViewModel.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/16/23.
//

import Foundation

class ScheduleViewModel {
    
    //MARK: - Variables
    
    static private let SECONDS_AFTER_RACE_TO_DETERMINE_PAST_RACES: Double = 21600
    
    var upcomingRaces: [Race]?
    var pastRaces: [Race]?
    
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
        
        dataManager.addListener(forType: [.schedule], listener: self)
    }
    
    
    //MARK: - Functions
    
    private func extractUpcomingRaces(schedule: [Race]) -> [Race] {
        let currDate = Date(timeIntervalSinceNow: ScheduleViewModel.SECONDS_AFTER_RACE_TO_DETERMINE_PAST_RACES)
        
        return schedule.filter { race in
            if let date = race.date {
                return date > currDate
            }
            
            return false
        }
    }
    
    private func extractPastRaces(schedule: [Race]) -> [Race] {
        let currDate = Date(timeIntervalSinceNow: ScheduleViewModel.SECONDS_AFTER_RACE_TO_DETERMINE_PAST_RACES)
        
        return schedule.filter { race in
            if let date = race.date {
                return date < currDate
            }
            
            return false
        }.sorted {
            if let date1 = $0.date, let date2 = $1.date {
                return date1 > date2
            }
            
            return false
        }
    }
}


//MARK: - DataListener delegate

extension ScheduleViewModel: DataListener {
    func dataIsUpdated(type: ListenerType) {
        if let schedule = CoreDataService.shared.getSchedule(forYear: dataManager.getCurrentRacingSeasonYear()), !schedule.isEmpty {
            self.upcomingRaces = self.extractUpcomingRaces(schedule: schedule)
            self.pastRaces = self.extractPastRaces(schedule: schedule)
            self.state = .success
        }
    }
    
    func errorOccured(error: Error) {
        self.state = .error(error)
    }
}
