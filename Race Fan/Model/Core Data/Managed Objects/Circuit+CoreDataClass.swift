//
//  Circuit+CoreDataClass.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/13/23.
//
//

import Foundation
import CoreData


public class Circuit: TimeStamp, Codable {
    
    enum CodingKeys: String, CodingKey {
        case circuitName
        case circuitId
        case wikipediaURL = "url"
        case location = "Location"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.circuitName = try container.decode(String.self, forKey: .circuitName)
        self.circuitId = try container.decode(String.self, forKey: .circuitId)
        self.wikipediaURL = try container.decode(String.self, forKey: .wikipediaURL)
        self.location = try container.decode(Location.self, forKey: .location)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.circuitName, forKey: .circuitName)
        try container.encode(self.circuitId, forKey: .circuitId)
        try container.encode(self.wikipediaURL, forKey: .wikipediaURL)
        try container.encode(self.location, forKey: .location)
    }
}
