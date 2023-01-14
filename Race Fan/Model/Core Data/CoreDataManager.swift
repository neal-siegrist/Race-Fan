//
//  CoreDataManager.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/12/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    //MARK: - Variables
    
    public static let shared = CoreDataManager()
    
    private var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Race_Fan")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    //MARK: - Initialization
    
    private init() {
        print("CoreDataManager initialized")
    }
    
    
    //MARK: - Functions
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getSchedule() {
        
    }
    
    func getDriverStandings() {
        
    }

    func getConstructorStandings() {
        
    }
}
