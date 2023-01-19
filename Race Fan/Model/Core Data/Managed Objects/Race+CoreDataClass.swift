//
//  Race+CoreDataClass.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/13/23.
//
//

import Foundation
import CoreData


public class Race: TimeStamp, Codable {
    
    enum CodingKeys: String, CodingKey {
        case date
        case raceName
        case round
        case season
        case time
        case wikipediaURL = "url"
        case circuit = "Circuit"
        case firstPractice = "FirstPractice"
        case qualifying = "Qualifying"
        case secondPractice = "SecondPractice"
        case sprint = "Sprint"
        case thirdPractice = "ThirdPractice"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let apiDate = try container.decode(String.self, forKey: .date)
        let apiTime = try container.decode(String.self, forKey: .time)
        
        self.date = structureDate(dateString: "\(apiDate) \(apiTime)")
        
        self.raceName = try container.decode(String.self, forKey: .raceName)
        self.round = try Int64(container.decode(String.self, forKey: .round)) ?? 0
        self.season = try Int64(container.decode(String.self, forKey: .season)) ?? 0
        self.wikipediaURL = try container.decode(String.self, forKey: .wikipediaURL)
        self.circuit = try container.decode(Circuit.self, forKey: .circuit)
        self.firstPractice = try container.decode(WeekendEvent.self, forKey: .firstPractice)
        self.secondPractice = try container.decode(WeekendEvent.self, forKey: .secondPractice)
        self.thirdPractice = try container.decodeIfPresent(WeekendEvent.self, forKey: .thirdPractice)
        self.qualifying = try container.decode(WeekendEvent.self, forKey: .qualifying)
        self.sprint = try container.decodeIfPresent(WeekendEvent.self, forKey: .sprint)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.date, forKey: .date)
        try container.encode(self.raceName, forKey: .raceName)
        try container.encode(self.round, forKey: .round)
        try container.encode(self.season, forKey: .season)
        try container.encode(self.wikipediaURL, forKey: .wikipediaURL)
        try container.encode(self.circuit, forKey: .circuit)
        try container.encode(self.firstPractice, forKey: .firstPractice)
        try container.encode(self.secondPractice, forKey: .secondPractice)
        try container.encode(self.thirdPractice, forKey: .thirdPractice)
        try container.encode(self.qualifying, forKey: .qualifying)
        try container.encode(self.sprint, forKey: .sprint)
    }
}
