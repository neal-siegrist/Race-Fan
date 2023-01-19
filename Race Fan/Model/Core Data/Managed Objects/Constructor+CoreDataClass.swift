//
//  Constructor+CoreDataClass.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/19/23.
//
//

import Foundation
import CoreData


public class Constructor: TimeStamp, Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "constructorId"
        case name
        case nationality
        case wikipediaURL = "url"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.nationality = try container.decode(String.self, forKey: .nationality)
        self.wikipediaURL = try container.decode(String.self, forKey: .wikipediaURL)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.nationality, forKey: .nationality)
        try container.encode(self.wikipediaURL, forKey: .wikipediaURL)
    }
}
