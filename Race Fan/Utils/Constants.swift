//
//  NetworkingConstants.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/13/23.
//

import UIKit

struct Constants {
    
    struct ApiEndPoints {
        public static let baseURL: String = "http://ergast.com/api/f1"
        public static let constructorStandingsURL: String = "/constructorStandings.json"
        public static let driverStandingsURL: String = "/driverStandings.json"
    }
    
    struct Colors {
        public static let driverTeams: [String: String] = [
            "albon": "williams",
            "alonso": "aston_martin",
            "bottas": "alfa",
            "gasly": "alpine",
            "hamilton": "mercedes",
            "hulkenberg": "haas",
            "leclerc": "ferrari",
            "kevin_magnussen": "haas",
            "norris": "mclaren",
            "ocon": "alpine",
            "perez": "red_bull",
            "piastri": "mclaren",
            "russell": "mercedes",
            "sainz": "ferrari",
            "sargeant": "williams",
            "stroll": "aston_martin",
            "tsunoda": "alphatauri",
            "max_verstappen": "red_bull",
            "de_vries": "alphatauri",
            "zhou": "alfa"
        ]
        
        public static let driverPrintableTeams: [String: String] = [
            "albon": "Williams",
            "alonso": "Aston Martin",
            "bottas": "Alfa Romeo",
            "gasly": "Alpine",
            "hamilton": "Mercedes",
            "hulkenberg": "Haas",
            "leclerc": "Ferrari",
            "kevin_magnussen": "Haas",
            "norris": "McLaren",
            "ocon": "Alpine",
            "perez": "Red Bull",
            "piastri": "McLaren",
            "russell": "Mercedes",
            "sainz": "Ferrari",
            "sargeant": "Williams",
            "stroll": "Aston Martin",
            "tsunoda": "Alpha Tauri",
            "max_verstappen": "Red Bull",
            "de_vries": "Alpha Tauri",
            "zhou": "Alfa Romeo"
        ]
        
        public static let teamColors: [String: UIColor] = [
            "red_bull": UIColor(red: 6.0/255.0, green: 0, blue: 239.0/255.0, alpha: 1),
            "ferrari": UIColor(red: 220.0/255.0, green: 0, blue: 0, alpha: 1),
            "mercedes": UIColor(red: 0, green: 161.0/255.0, blue: 155.0/255.0, alpha: 1),
            "alpine": UIColor(red: 0, green: 144.0/255.0, blue: 1, alpha: 1),
            "mclaren": UIColor(red: 1, green: 135.0/255.0, blue: 0, alpha: 1),
            "alfa": UIColor(red: 144.0/255.0, green: 0, blue: 0, alpha: 1),
            "aston_martin": UIColor(red: 0, green: 111.0/255.0, blue: 98.0/255.0, alpha: 1),
            "haas": UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1),
            "alphatauri": UIColor(red: 43.0/255.0, green: 69.0/255.0, blue: 98.0/255.0, alpha: 1),
            "williams": UIColor(red: 0, green: 90.0/255.0, blue: 1, alpha: 1),
        ]
    }
}
