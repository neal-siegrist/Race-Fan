//
//  DataManager.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/14/23.
//

import Foundation

class DataManager {
    
    //MARK: - Variables
    private static let DAYS_UNTIL_SCHEDULE_REFRESH: Double = 21
    
    let coreDataManager: CoreDataManager
    
    
    //MARK: - Initializers
    
    init() {
        self.coreDataManager = CoreDataManager.shared
    }
    
    
    //MARK: - Functions
    
    func getUpcomingRace(completion: @escaping (Result<Race, NetworkingError>) -> Void) {
        
        let year = getCurrentRacingSeasonYear()
        
        if let coreDataSchedule = getCoreDataRaceSchedule(year: year), !coreDataSchedule.isEmpty, !isRefreshNeeded(item: coreDataSchedule.first) {
            
            if let firstUpcomingRace = extractFirstUpcomingRaceFromSchedule(schedule: coreDataSchedule) {
                completion(.success(firstUpcomingRace))
                return
            }
        }
        
        coreDataManager.deleteSchedule(forYear: year)
        
        self.getApiRaceSchedule(year: year) { [weak self] result in
            switch result {
            case .success(let schedule):
                if let firstUpcomingRace = self?.extractFirstUpcomingRaceFromSchedule(schedule: schedule) {
                    completion(.success(firstUpcomingRace))
                    return
                }
                
                completion(.failure(.noData))
                
            case .failure(let networkingError):
                completion(.failure(networkingError))
            }
        }
    }
    
    func getSchedule(completion: @escaping (Result<[Race], NetworkingError>) -> Void) {
        
        let year = getCurrentRacingSeasonYear()
        
        if let coreDataSchedule = getCoreDataRaceSchedule(year: year), !coreDataSchedule.isEmpty, !isRefreshNeeded(item: coreDataSchedule.first) {
            
            completion(.success(coreDataSchedule))
            return
        }
        
        coreDataManager.deleteSchedule(forYear: year)
        
        self.getApiRaceSchedule(year: year) { result in
            switch result {
            case .success(let schedule):
                if !schedule.isEmpty {
                    completion(.success(schedule))
                } else {
                    completion(.failure(.noData))
                }
                
            case .failure(let networkingError):
                completion(.failure(networkingError))
            }
        }
    }
    
    private func getCoreDataRaceSchedule(year: Int) -> [Race]? {
        return coreDataManager.getSchedule(forYear: year)
    }
    
    private func getApiRaceSchedule(year: Int, completion: @escaping (Result<[Race], NetworkingError>) -> Void ) {
        
        guard let url = URL(string: "http://ergast.com/api/f1/\(year).json") else { return }
        guard let urlRequest = NetworkingManager.generateUrlRequest(url: url) else { return }

        NetworkingManager.loadData(request: urlRequest, type: JSONTopLevelKey.self) { [weak self] result in
            switch result {
            case .success(_):
                self?.coreDataManager.saveContext()
                
                if let coreDataSchedule = self?.getCoreDataRaceSchedule(year: year), !coreDataSchedule.isEmpty {
                    completion(.success(coreDataSchedule))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let networkingError):
                completion(.failure(networkingError))
            }
        }
    }
    
    private func getCurrentRacingSeasonYear() -> Int {
        return Calendar.current.component(.year, from: Date())
    }
    
    private func isRefreshNeeded(item: TimeStamp?) -> Bool {
        if let item = item, let creationData = item.dateCreated {
            return Date(timeIntervalSinceNow: -(86400 * DataManager.DAYS_UNTIL_SCHEDULE_REFRESH)) > creationData
        }
        
        return false
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
