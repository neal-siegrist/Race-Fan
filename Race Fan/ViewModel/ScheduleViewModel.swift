//
//  ScheduleViewModel.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/16/23.
//

import Foundation

class ScheduleViewModel {
    
    //MARK: - Variables
    
    var upcomingRaces: [Race]?
    var pastRaces: [Race]?
    
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
    
    private func extractUpcomingRaces(schedule: [Race]) -> [Race] {
        let currDate = Date(timeIntervalSinceNow: 8640000.0)
        
        return schedule.filter { race in
            if let date = race.date {
                return date > currDate
            }
            
            return false
        }
    }
    
    private func extractPastRaces(schedule: [Race]) -> [Race] {
        let currDate = Date(timeIntervalSinceNow: 8640000.0)
        
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

extension ScheduleViewModel: ScheduleViewModelDelegate {
    func fetchSchedule() {
        
        dataManager.getSchedule { [weak self] result in
            switch result {
            case .success(let schedule):
                print("in get schedule view model success")
                self?.upcomingRaces = self?.extractUpcomingRaces(schedule: schedule)
                self?.pastRaces = self?.extractPastRaces(schedule: schedule)
                self?.state = .success
            case .failure(let networkingError):
                print(networkingError)
                self?.state = .error(networkingError)
            }
            
            
        }
        
    }
}
