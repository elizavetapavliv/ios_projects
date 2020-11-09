//
//  CompositionsEntity.swift
//  GreenhouseApp
//
//  Created by Lizaveta Rudzko on 3/15/1398 AP.
//

import Foundation
import CoreData

class CompositionsEntity
{
    private var databaseObject: NSManagedObject?
    private var databaseObjects = [NSManagedObject]()
    
    init(persistentContainer: NSPersistentContainer, composition_name: String) // ??
    {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Compositions")
        request.predicate = NSPredicate(format: "composition_name = %@", composition_name)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        
        if objects.count > 0
        {
            self.databaseObject = objects[0]
        } else {
            self.databaseObject = nil
        }
    }
    
    init(persistentContainer: NSPersistentContainer, login: String) // ??
    {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Compositions")
        request.predicate = NSPredicate(format: "login = %@", login)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        
        if objects.count > 0
        {
            self.databaseObjects = objects
        }
    }
    
    func getByLogin() -> [NSManagedObject]
    {
        return databaseObjects
    }
    
    init(persistentContainer: NSPersistentContainer, amount: Int32, cost: Int32, composition_name: String)
    {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Compositions", in: managedContext)!
        let id = try! managedContext.count(for: NSFetchRequest(entityName: "Compositions"))
        
        databaseObject = NSManagedObject(entity: entity, insertInto: managedContext)
        databaseObject!.setValue(id + 1, forKey: "id")
        databaseObject!.setValue(amount, forKey: "amount")
        databaseObject!.setValue(cost, forKey: "cost")
        databaseObject!.setValue(composition_name, forKey: "composition_name")
        
        try! managedContext.save()
    }
    
    func delete(persistentContainer: NSPersistentContainer)
    {
        persistentContainer.viewContext.delete(databaseObject!)
        try! persistentContainer.viewContext.save()
    }
    
    func id() -> Int32?
    {
        return databaseObject?.value(forKey: "id") as? Int32
    }
    
    func composition_name() -> String?
    {
        return databaseObject?.value(forKey: "composition_name") as? String
    }
    
    func amount() -> Int32?
    {
        return databaseObject?.value(forKey: "amount") as? Int32
    }
    
    func cost() -> Int32?
    {
        return databaseObject?.value(forKey: "cost") as? Int32
    }
}
