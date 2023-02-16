//
//  TimeStamp+CoreDataClass.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/13/23.
//
//

import Foundation
import CoreData

public class TimeStamp: NSManagedObject {

    func sign() {
        let now = Date()
        
        if self.dateCreated == .none {
            self.dateCreated = now
        }
        
        self.dateModified = now
    }
    
    func structureDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        return dateFormatter.date(from: dateString)
    }
    
    func structureDateWithNoTime(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: dateString)
    }
}
