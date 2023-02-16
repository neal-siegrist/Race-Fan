//
//  Driver+CoreDataClass.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/19/23.
//
//

import Foundation
import CoreData

public class Driver: TimeStamp, Codable {
    
    enum CodingKeys: String, CodingKey {
        case permanentNumber
        case code
        case familyName
        case givenName
        case id = "driverId"
        case nationality
        case wikipediaURL = "url"
        case dateOfBirth
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.permanentNumber = try Int64(container.decode(String.self, forKey: .permanentNumber)) ?? 0
        self.code = try container.decode(String.self, forKey: .code)
        self.familyName = try container.decode(String.self, forKey: .familyName)
        self.givenName = try container.decode(String.self, forKey: .givenName)
        self.id = try container.decode(String.self, forKey: .id)
        self.nationality = try container.decode(String.self, forKey: .nationality)
        self.wikipediaURL = try container.decode(String.self, forKey: .wikipediaURL)
        
        let apiDate = try container.decode(String.self, forKey: .dateOfBirth)
        self.dateOfBirth = structureDateWithNoTime(dateString: apiDate)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.permanentNumber, forKey: .permanentNumber)
        try container.encode(self.code, forKey: .code)
        try container.encode(self.familyName, forKey: .familyName)
        try container.encode(self.givenName, forKey: .givenName)
        try container.encode(self.wikipediaURL, forKey: .wikipediaURL)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.nationality, forKey: .nationality)
        try container.encode(self.wikipediaURL, forKey: .wikipediaURL)
        try container.encode(self.dateOfBirth, forKey: .dateOfBirth)
    }
}
