//
//  DataManager.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/14/23.
//

import Foundation

class DataManager {
     
    //MARK: - Variables
    public static let shared = DataManager()
    
    public static let DAYS_UNTIL_SCHEDULE_REFRESH: Double = 21
    
    public static let DRIVER_STANDINGS_ENTITY_NAME: String = "DriverStandings"
    public static let CONSTRUCTOR_STANDINGS_ENTITY_NAME: String = "ConstructorStandings"
    public static let SCHEDULE_ENTITY_NAME: String = "Race"
    
    private let coreDataService = CoreDataService.shared
    
    private var scheduleListeners: [DataListener] = []
    private var driverStandingsListeners: [DataListener] = []
    private var constructorStandingsListeners: [DataListener] = []
    
    //MARK: - Initializers
    
    private init() {}
    
    
    //MARK: - Functions
    
    func addListener(forType: [ListenerType], listener: DataListener) {
        for type in forType {
            switch type {
                case .schedule:
                    scheduleListeners.append(listener)
                case .driver:
                    driverStandingsListeners.append(listener)
                case .constructor:
                    constructorStandingsListeners.append(listener)
            }
        }
    }
    
    func fetchAllData() {
        fetchSchedule()
        fetchDriverStandings()
        fetchConstructorStandings()
    }
    
    func fetchSchedule() {
        let year = getCurrentRacingSeasonYear()
        
        if let schedule = coreDataService.getSchedule(forYear: year), !schedule.isEmpty, !isRefreshNeeded(item: schedule.first, type: .schedule) {
            notifyListenersOfSuccess(forType: .schedule)
        } else {
            coreDataService.performDeletion(forYear: year, entityName: DataManager.SCHEDULE_ENTITY_NAME)
            
            guard let url = URL(string: "\(Constants.ApiEndPoints.baseURL)/\(year).json") else { return }
            guard let urlRequest = NetworkingManager.generateUrlRequest(url: url) else { return }
            
            performNetworkRequest(request: urlRequest, parsingType: ScheduleParsing.self, listenerType: .schedule)
        }
    }
    
    func fetchDriverStandings() {
        let year = getCurrentRacingSeasonYear()
        
        if let driverStandings = coreDataService.getDriverStandings(forYear: year), !driverStandings.isEmpty, !isRefreshNeeded(item: driverStandings.first, type: .driver) {
            notifyListenersOfSuccess(forType: .driver)
        } else {
            coreDataService.performDeletion(forYear: year, entityName: DataManager.DRIVER_STANDINGS_ENTITY_NAME)
            
            guard let url = URL(string: "\(Constants.ApiEndPoints.baseURL)/\(year)\(Constants.ApiEndPoints.driverStandingsURL)") else { return }
            guard let urlRequest = NetworkingManager.generateUrlRequest(url: url) else { return }
            
            performNetworkRequest(request: urlRequest, parsingType: DriverStandingsParsing.self, listenerType: .driver)
        }
    }
    
    func fetchConstructorStandings() {
        let year = getCurrentRacingSeasonYear()
        
        if let constructorStandings = coreDataService.getConstructorStandings(forYear: year), !constructorStandings.isEmpty, !isRefreshNeeded(item: constructorStandings.first, type: .constructor) {
            notifyListenersOfSuccess(forType: .constructor)
        } else {
            coreDataService.performDeletion(forYear: year, entityName: DataManager.CONSTRUCTOR_STANDINGS_ENTITY_NAME)
            
            guard let url = URL(string: "\(Constants.ApiEndPoints.baseURL)/\(year)\(Constants.ApiEndPoints.constructorStandingsURL)") else { return }
            guard let urlRequest = NetworkingManager.generateUrlRequest(url: url) else { return }
            
            performNetworkRequest(request: urlRequest, parsingType: ConstructorStandingsParsing.self, listenerType: .constructor)
        }
    }
    
    private func performNetworkRequest<T: Decodable>(request: URLRequest, parsingType: T.Type, listenerType: ListenerType) {
        NetworkingManager.loadData(request: request, type: T.self) { [weak self] result in
            switch result {
            case .success(_):
                CoreDataStack.shared.saveContext()
                self?.notifyListenersOfSuccess(forType: listenerType)
            case .failure(let networkingError):
                self?.notifyListenersOfFailure(forType: listenerType, error: networkingError)
            }
        }
    }
    
    func getCurrentRacingSeasonYear() -> Int {
        return Calendar.current.component(.year, from: Date())
    }
    
    private func isRefreshNeeded(item: TimeStamp?, type: ListenerType) -> Bool {
        if let item = item, let creationData = item.dateCreated {
            switch type {
            case .schedule:
                return Date(timeIntervalSinceNow: -(86400 * DataManager.DAYS_UNTIL_SCHEDULE_REFRESH)) > creationData
            case .driver, .constructor:
                //TODO: Update to calculate standings refresh
                return Date(timeIntervalSinceNow: -(86400 * DataManager.DAYS_UNTIL_SCHEDULE_REFRESH)) > creationData
            }
        }
        
        return false
    }
    
    private func notifyListenersOfSuccess(forType: ListenerType) {
        switch forType {
            case .constructor:
                for constructorStandingsListener in constructorStandingsListeners {
                    constructorStandingsListener.dataIsUpdated(type: .constructor)
                }
            case .driver:
                for driverStandingsListener in driverStandingsListeners {
                    driverStandingsListener.dataIsUpdated(type: .driver)
                }
            case .schedule:
                for scheduleListener in scheduleListeners {
                    scheduleListener.dataIsUpdated(type: .schedule)
                }
        }
    }
    
    private func notifyListenersOfFailure(forType: ListenerType, error: Error) {
        switch forType {
            case .constructor:
                for constructorStandingsListener in constructorStandingsListeners {
                    constructorStandingsListener.errorOccured(error: error)
                }
            case .driver:
                for driverStandingsListener in driverStandingsListeners {
                    driverStandingsListener.errorOccured(error: error)
                }
            case .schedule:
                for scheduleListener in scheduleListeners {
                    scheduleListener.errorOccured(error: error)
                }
        }
    }
}
