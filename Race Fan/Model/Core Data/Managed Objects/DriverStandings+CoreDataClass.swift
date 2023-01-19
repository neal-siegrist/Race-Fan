//
//  DriverStandings+CoreDataClass.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/19/23.
//
//

import Foundation
import CoreData


public class DriverStandings: TimeStamp, Codable {
    
    enum CodingKeys: String, CodingKey {
        case round
        case season
        case standings = "DriverStandings"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.round = try Int64(container.decode(String.self, forKey: .round)) ?? 0
        self.season = try Int64(container.decode(String.self, forKey: .season)) ?? 0
        
        self.standings = try NSSet(array: container.decode([DriverStandingItem].self, forKey: .standings))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.round, forKey: .round)
        try container.encode(self.season, forKey: .season)
        
        try container.encode(self.standings as! Set<DriverStandingItem>, forKey: .standings)
    }
}
