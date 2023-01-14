//
//  DataManager.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/12/23.
//

import Foundation

class DataManager {
    
    let coreDataManager = CoreDataManager.shared
    
    
    func getSchedule() {
        guard let url = URL(string: "http://ergast.com/api/f1/2023.json") else { return }
        
        guard let urlRequest = Networking.generateUrlRequest(url: url) else { return }
        
        Networking.loadData(request: urlRequest, type: JSONTopLevelKey.self) { result in
            switch result {
            case .failure(let error):
                print("Error occured: \(error)")
            case .success(let data):
                print(data)
            }
        }
    }
    
    func getDriverStandings() {
        
    }
    
    func getConstructorStandings() {
        
    }
}
