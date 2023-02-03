//
//  CoreDataService.swift
//  Race Fan
//
//  Created by Neal Siegrist on 2/2/23.
//

import Foundation
import CoreData

class CoreDataService {
    
    //MARK: - Variables
    
    public static let shared = CoreDataService()
    
    var coreDataStack = CoreDataStack.shared
    
    //MARK: - Initializers
    
    private init() {}
    
    
    //MARK: - Functions
    
    func getSchedule(forYear: Int) -> [Race]? {
        let fetchRequest: NSFetchRequest<Race> = Race.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "season == %i", forYear)
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "round", ascending: true)]
        
        do {
            let races = try coreDataStack.mainContext.fetch(fetchRequest)
            return races
        } catch let error {
            print("Failed to fetch races: \(error)")
        }
        
        return nil
    }
    
    func getDriverStandings(forYear: Int) -> [DriverStandingItem]? {
        let fetchRequest: NSFetchRequest<DriverStandings> = DriverStandings.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "season == %i", forYear)
        
        do {
            let driverStandings = try coreDataStack.mainContext.fetch(fetchRequest)
            return driverStandings.first?.standings?.allObjects as? [DriverStandingItem]
        } catch {
            print("Failed to fetch standings: \(error)")
        }
        
        return nil
    }
    
    func getConstructorStandings(forYear: Int) -> [ConstructorStandingItem]? {
        let fetchRequest: NSFetchRequest<ConstructorStandings> = ConstructorStandings.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "season == %i", forYear)
        
        do {
            let constructorStandings = try coreDataStack.mainContext.fetch(fetchRequest)
            return constructorStandings.first?.standings?.allObjects as? [ConstructorStandingItem]
        } catch {
            print("Failed to fetch standings: \(error)")
        }
        
        return nil
    }
    
    func performDeletion(forYear: Int, entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        
        fetchRequest.predicate = NSPredicate(format: "season == %i", forYear)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coreDataStack.mainContext.execute(deleteRequest)
        } catch {
            print("Error deleting entity for given year: \(error)")
        }
    }
}
