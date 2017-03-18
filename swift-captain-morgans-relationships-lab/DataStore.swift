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
    
    // helper functions
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
    
    func getShip(by name: String)-> Ship?{
        return ships.first(where: {$0.name == name})
    }//trist to find first ship with a given name
    
    //Test data setup
    func generateTestData(){
        
        let context = persistentContainer.viewContext
        //20 pirates 10 ships per p
        print("In generateTestData")
        
        for count in 0..<20{
            var name = makePirateName()
            let pirate: Pirate = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context) as! Pirate
            pirate.name = name
            pirates.append(pirate)
            for count2 in 0..<10{
                name = "Ship_\(count2)"
                
                let ship: Ship = NSEntityDescription.insertNewObject(forEntityName: "Ship", into: context) as! Ship
                ship.name = makeShipName()
                ship.pirate = pirates[count]
                
                let engine: Engine = NSEntityDescription.insertNewObject(forEntityName: "Engine", into: context) as! Engine
                let types = ["Sail", "Gas", "Oars", "Nuclear"]
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
    
    // MARK: Goofy Name Generators
    func makePirateName()-> String{
        let adjectives = ["Black","Blue","Red","Golden","Bloody","Drunken","Sea","Murder","Death","Jolly","Gray","Salty","Long"]
        let nouns = [" Roger"," Jack"," Jim","beard","legs"," Edward"," PegLeg","scourge","bones","bane", " John"]
        let titles = [" Silver"," the Cruel"," the Jolly", " the Admiral", " the Drunkard"," Scurvy", " Scallywag", " Ironsides", " the Buccanneer", " Morgan"]
        
        let adjective = adjectives[Int(arc4random_uniform(UInt32(adjectives.count)))]
        let noun = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
        let title = titles[Int(arc4random_uniform(UInt32(titles.count)))]
        
        return adjective + noun + title
    }
    
    func makeShipName()-> String {
        let adjectives = ["Black","Blue","Red","Golden","Bloody","Drunk","Sea","Murder","Death","Jolly","Gray","Salty","Long"]
        let nouns = [" Raven", " Admiral", " Standard", " Kraken", " Leviathan", " Dragon", " Sunset", " Shark", " Cannon", " Herald", " Lady", " Sally", " Sails", " Decks"]
        let descriptors = [" Good Ship ", " Stealthy ", " Fierce ", " Terrifying ", " Murderous ", " Ironsides ", " Veteran ", " Creaky ", " Swift ", " Captured "]
        
        let adjective = adjectives[Int(arc4random_uniform(UInt32(adjectives.count)))]
        let noun = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
        let descriptor = descriptors[Int(arc4random_uniform(UInt32(descriptors.count)))]
        
        return "The " + descriptor + adjective + noun
    }
}

