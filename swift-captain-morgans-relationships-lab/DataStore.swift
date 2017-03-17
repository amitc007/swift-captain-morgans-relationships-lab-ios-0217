//
//  DataStore.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Edmund Holderbaum on 3/17/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation
import CoreData


final class DataStore {
    
    static let  shared = DataStore()
    
    
    fileprivate var pirates: [Pirate] = []
    fileprivate var ships: [Ship] = []
    fileprivate var engines: [Engine] = []
    
    private init() {   }
    
    func getPiratesCount()->Int {
        
        return pirates.count
    }
    
    func getShipsCount()->Int {
        
        return ships.count
    }
    
    
    func getPirate(at index: Int)-> Pirate {
        return pirates[index]
    }
    
    func getShip(at index: Int)-> Ship{
        return ships[index]
    }
    
    func getEngine(at index: Int)-> Engine{
        return engines[index]
    }
    
    func generateTestData(){
        
        let context = persistentContainer.viewContext
        //let fetchReq: NSFetchRequest<Pirate> = Pirate.fetchRequest()
        
        //20 pirates 10 ships per p
        print("In generateTestData")
        
        for count in 0..<20{
            var name = "Pirate_\(count)"
            let pirate: Pirate = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context) as! Pirate
            pirate.name = name
            pirates.append(pirate)
            for count2 in 0..<10{
                name = "Ship_\(count2)"
                
                let ship: Ship = NSEntityDescription.insertNewObject(forEntityName: "Ship", into: context) as! Ship
                ship.name = name
                ship.pirate = pirates[count]
                
                let engine: Engine = NSEntityDescription.insertNewObject(forEntityName: "Engine", into: context) as! Engine
                let types = ["sail", "gas", "oars", "nuclear"]
                engine.engineType = types[Int(arc4random_uniform(4))]
                engines.append(engine)
                ship.engine = engine
                ships.append(ship)
            }
        }
        
        saveContext()
        fetchData()
        
    }
    
    
    func fetchData() {
        
        let context = persistentContainer.viewContext
        let fetchReq: NSFetchRequest<Pirate> = Pirate.fetchRequest()
        
        do {
            pirates = try context.fetch(fetchReq)
        } catch {   }

    }
    
    
    // MARK:  -  Persistent Container for Data Model
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
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
}

