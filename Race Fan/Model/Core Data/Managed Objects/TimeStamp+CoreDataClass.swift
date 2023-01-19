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
        
        let date = dateFormatter.date(from: dateString)
        print(date)
        return date
    }
    
    func structureDateWithNoTime(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: dateString)
        print(date)
        return date
    }
}
