//
//  Location+CoreDataClass.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/13/23.
//
//

import Foundation
import CoreData

public class Location: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case country
        case latitude = "lat"
        case locality
        case longitude = "long"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.country = try container.decode(String.self, forKey: .country)
        self.latitude = try Double(container.decode(String.self, forKey: .latitude)) ?? 0
        self.locality = try container.decode(String.self, forKey: .locality)
        self.longitude = try Double(container.decode(String.self, forKey: .longitude)) ?? 0
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.country, forKey: .country)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.locality, forKey: .locality)
        try container.encode(self.longitude, forKey: .longitude)
    }
}
