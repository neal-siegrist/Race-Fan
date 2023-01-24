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
                //TODO: - Maybe throw error here
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
                for object in context.updatedObjects {
                    
                    if let signatureObject = object as? TimeStamp {
                        signatureObject.sign()
                    }
                }
                
                for object in context.insertedObjects {
                    
                    if let signatureObject = object as? TimeStamp {
                        signatureObject.sign()
                    }
                }
                
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //TODO: - Maybe throw error here
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getSchedule(forYear: Int) -> [Race]? {
        
        let fetchRequest = NSFetchRequest<Race>(entityName: "Race")
        
        fetchRequest.predicate = NSPredicate(format: "season == %i", forYear)
        
        let sortDescriptor = NSSortDescriptor(key: "round", ascending: true)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            let races = try persistentContainer.viewContext.fetch(fetchRequest)
            return races
        } catch let error {
            //TODO: - Maybe throw error here
            print("Failed to fetch races: \(error)")
        }
        
        return nil
    }
    
    func performDeletion(forYear: Int, entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        
        fetchRequest.predicate = NSPredicate(format: "season == %i", forYear)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            //TODO: - Maybe throw error here
            print("Error deleting schedule for given year: \(error)")
        }
    }
    
    func getDriverStandings(forYear: Int) -> DriverStandings? {
        
        let fetchRequest = NSFetchRequest<DriverStandings>(entityName: "DriverStandings")
        
        fetchRequest.predicate = NSPredicate(format: "season == %i", forYear)
        
        do {
            let driverStandings = try persistentContainer.viewContext.fetch(fetchRequest)
            return driverStandings.first
        } catch let error {
            //TODO: - Maybe throw error here
            print("Failed to fetch races: \(error)")
        }
        
        return nil
    }
    
    func getConstructorStandings(forYear: Int) -> ConstructorStandings? {
        
        let fetchRequest = NSFetchRequest<ConstructorStandings>(entityName: "ConstructorStandings")
        
        fetchRequest.predicate = NSPredicate(format: "season == %i", forYear)
        
        do {
            let constructorStandings = try persistentContainer.viewContext.fetch(fetchRequest)
            return constructorStandings.first
        } catch let error {
            //TODO: - Maybe throw error here
            print("Failed to fetch races: \(error)")
        }
        
        return nil
    }
}
