//
//  ConstructorStandingItem+CoreDataClass.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/20/23.
//
//

import Foundation
import CoreData


public class ConstructorStandingItem: TimeStamp, Codable {

    enum CodingKeys: String, CodingKey {
        case points
        case position
        case wins
        case constructor = "Constructor"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.points = try Int64(container.decode(String.self, forKey: .points)) ?? 0
        self.position = try Int64(container.decode(String.self, forKey: .position)) ?? 0
        self.wins = try Int64(container.decode(String.self, forKey: .wins)) ?? 0
        self.constructor = try container.decode(Constructor.self, forKey: .constructor)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.points, forKey: .points)
        try container.encode(self.position, forKey: .position)
        try container.encode(self.wins, forKey: .wins)
        try container.encode(self.constructor, forKey: .constructor)
    }
}
