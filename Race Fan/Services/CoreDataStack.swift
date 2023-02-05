//
//  CoreDataStack.swift
//  Race Fan
//
//  Created by Neal Siegrist on 2/2/23.
//

import Foundation
import CoreData

class CoreDataStack {
    
    //MARK: - Variables
    public static let shared = CoreDataStack()
    public static let MODEL_NAME = "Race_Fan_Model"
    
    var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.MODEL_NAME)
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error loading persistent container. Error: \(error)")
            }
        }
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        get {
            return container.viewContext
        }
    }
    
    
    //MARK: - Initializers
    
    private init() {}
    
    
    //MARK: - Functions
    
    func saveContext() {
        if mainContext.hasChanges {
            addTimestamps()
            
            do {
                try mainContext.save()
            } catch {
                fatalError("Error saving core data context. Error: \(error)")
            }
        }
    }
    
    private func addTimestamps() {
        for object in mainContext.updatedObjects {
            
            if let signatureObject = object as? TimeStamp {
                signatureObject.sign()
            }
        }
        
        for object in mainContext.insertedObjects {
            
            if let signatureObject = object as? TimeStamp {
                signatureObject.sign()
            }
        }
    }
}
