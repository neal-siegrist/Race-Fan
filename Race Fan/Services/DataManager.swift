//
//  DataManager.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/14/23.
//

import Foundation

class DataManager {
    
    //MARK: - Variables
    public static let DAYS_UNTIL_SCHEDULE_REFRESH: Double = 21
    public static let RACE_ENTITY_NAME: String = "Race"
    public static let DRIVER_STANDINGS_ENTITY_NAME: String = "DriverStandings"
    public static let CONSTRUCTOR_STANDINGS_ENTITY_NAME: String = "ConstructorStandings"
    
    let coreDataManager: CoreDataManager
    
    
    //MARK: - Initializers
    
    init() {
        self.coreDataManager = CoreDataManager.shared
    }
    
    
    //MARK: - Functions
    
    //func getConstructorStandings
    
    func getConstructorStandings(completion: @escaping (Result<ConstructorStandings, NetworkingError>) -> Void) {
        //let year = getCurrentRacingSeasonYear()
        let year = 2022
        
        if let coreDataConstructorStanding = getCoreDataConstructorStandings(year: year), let standings = coreDataConstructorStanding.standings?.allObjects as? [ConstructorStandingItem], !standings.isEmpty, !isRefreshNeeded(item: standings.first) {
            print("Successfully retrieved data from core data for driver standings")
            
            completion(.success(coreDataConstructorStanding))
            
            return
        }
        
        coreDataManager.performDeletion(forYear: year, entityName: DataManager.CONSTRUCTOR_STANDINGS_ENTITY_NAME)
        
        self.getApiConstructorStandings(year: year) { result in
            switch result {
            case .success(let constructorStandings):
                
                if constructorStandings.standings != nil {
                    print("constructorStandingsArray is not nil and calling with success")
                    completion(.success(constructorStandings))
                    return
                }

                print("constructorStandingsArray is nil and calling with failure and .noData error")
                completion(.failure(.noData))

            case .failure(let networkingError):
                print("In failure of getConstructorStandings with error:\(networkingError)")
                completion(.failure(networkingError))
            }
        }
    }
    
    func getDriverStandings(completion: @escaping (Result<DriverStandings, NetworkingError>) -> Void) {
        //let year = getCurrentRacingSeasonYear()
        let year = 2022
        
        if let coreDataDriverStanding = getCoreDataDriverStandings(year: year), let standings = coreDataDriverStanding.standings?.allObjects as? [DriverStandingItem], !standings.isEmpty, !isRefreshNeeded(item: standings.first) {
            print("Successfully retrieved data from core data for driver standings")
            
            completion(.success(coreDataDriverStanding))
            
            return
        }
        
        coreDataManager.performDeletion(forYear: year, entityName: DataManager.DRIVER_STANDINGS_ENTITY_NAME)
        
        self.getApiDriverStandings(year: year) { result in
            switch result {
            case .success(let driverStandings):
                
                if driverStandings.standings != nil {
                    print("standingsArray is not nil and calling with success")
                    completion(.success(driverStandings))
                    return
                }

                print("standingsArray is nil and calling with failure and .noData error")
                completion(.failure(.noData))

            case .failure(let networkingError):
                print("In failure of getDriverStandings with error:\(networkingError)")
                completion(.failure(networkingError))
            }
        }
    }
    
    
    
    func getUpcomingRace(completion: @escaping (Result<Race, NetworkingError>) -> Void) {
        
        let year = getCurrentRacingSeasonYear()
        
        if let coreDataSchedule = getCoreDataRaceSchedule(year: year), !coreDataSchedule.isEmpty, !isRefreshNeeded(item: coreDataSchedule.first) {
            
            if let firstUpcomingRace = extractFirstUpcomingRaceFromSchedule(schedule: coreDataSchedule) {
                completion(.success(firstUpcomingRace))
                return
            }
        }
        
        coreDataManager.performDeletion(forYear: year, entityName: DataManager.RACE_ENTITY_NAME)
        
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
        
        coreDataManager.performDeletion(forYear: year, entityName: DataManager.RACE_ENTITY_NAME)
        
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
    
    private func getCoreDataConstructorStandings(year: Int) -> ConstructorStandings? {
        return coreDataManager.getConstructorStandings(forYear: year)
    }
    
    private func getCoreDataDriverStandings(year: Int) -> DriverStandings? {
        return coreDataManager.getDriverStandings(forYear: year)
    }
    
    private func getCoreDataRaceSchedule(year: Int) -> [Race]? {
        return coreDataManager.getSchedule(forYear: year)
    }
    
    private func getApiRaceSchedule(year: Int, completion: @escaping (Result<[Race], NetworkingError>) -> Void ) {
        
        guard let url = URL(string: "\(Constants.ApiEndPoints.baseURL)/\(year).json") else { return }
        guard let urlRequest = NetworkingManager.generateUrlRequest(url: url) else { return }

        NetworkingManager.loadData(request: urlRequest, type: ScheduleParsing.self) { [weak self] result in
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
    
    private func getApiDriverStandings(year: Int, completion: @escaping (Result<DriverStandings, NetworkingError>) -> Void) {
        
        guard let url = URL(string: "\(Constants.ApiEndPoints.baseURL)/\(year)\(Constants.ApiEndPoints.driverStandingsURL)") else { return }
        guard let urlRequest = NetworkingManager.generateUrlRequest(url: url) else { return }

        NetworkingManager.loadData(request: urlRequest, type: DriverStandingsParsing.self) { [weak self] result in
            switch result {
            case .success(_):
                self?.coreDataManager.saveContext()
                
                if let coreDataSchedule = self?.getCoreDataDriverStandings(year: year) {
                    completion(.success(coreDataSchedule))
                } else {
                    print("In getApiDriverStandings error occured: saved context but error fetching fresh data from core data")
                    completion(.failure(.noData))
                }
            case .failure(let networkingError):
                print("In getApiDriverStandings error occured: \(networkingError)")
                completion(.failure(networkingError))
            }
        }
    }
    
    private func getApiConstructorStandings(year: Int, completion: @escaping (Result<ConstructorStandings, NetworkingError>) -> Void) {
        
        guard let url = URL(string: "\(Constants.ApiEndPoints.baseURL)/\(year)\(Constants.ApiEndPoints.constructorStandingsURL)") else { return }
        guard let urlRequest = NetworkingManager.generateUrlRequest(url: url) else { return }

        NetworkingManager.loadData(request: urlRequest, type: ConstructorStandingsParsing.self) { [weak self] result in
            switch result {
            case .success(_):
                self?.coreDataManager.saveContext()
                
                if let coreDataSchedule = self?.getCoreDataConstructorStandings(year: year) {
                    completion(.success(coreDataSchedule))
                } else {
                    print("In getApiConstructorStandings error occured: saved context but error fetching fresh data from core data")
                    completion(.failure(.noData))
                }
            case .failure(let networkingError):
                print("In getApiConstructorStandings error occured: \(networkingError)")
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
