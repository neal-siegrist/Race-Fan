//
//  WeekendEvent+CoreDataClass.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/13/23.
//
//

import Foundation
import CoreData


public class WeekendEvent: NSManagedObject, Codable {

    enum CodingKeys: CodingKey {
        case date
        case time
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let apiTime = try container.decode(String.self, forKey: .time)
        let apiDate = try container.decode(String.self, forKey: .date)
        
        let combinedDateTime = ("\(apiDate) \(apiTime)")
        
        self.date = structureDate(dateString: combinedDateTime)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.date, forKey: .date)
    }
    
    private func structureDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        let date = dateFormatter.date(from: dateString)
        print(date)
        
        return date
    }
    
}
