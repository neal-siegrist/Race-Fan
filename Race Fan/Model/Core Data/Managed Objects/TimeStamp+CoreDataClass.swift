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
    
}
