//
//  Flower_compositionsEntity.swift
//  GreenhouseApp
//
//  Created by Lizaveta Rudzko on 3/15/1398 AP.
//

import UIKit
import Foundation
import CoreData

class Flower_compositionsEntity
{
    private var databaseObject: NSManagedObject?
    private var databaseObjects = [NSManagedObject]()
    
    init(persistentContainer: NSPersistentContainer, composition_name: String) // ??
    {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Flower_compositions")
        request.predicate = NSPredicate(format: "composition_name = %@", composition_name)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        
        if objects.count > 0
        {
            self.databaseObjects = objects
        }
    }
    
    func getByCompName() -> [NSManagedObject]
    {
        return databaseObjects
    }
    
    
    init(persistentContainer: NSPersistentContainer, amount: Int32, cost: Int32, composition_name: String, kind: String, name: String)
    {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Flower_compositions", in: managedContext)!
        let id = try! managedContext.count(for: NSFetchRequest(entityName: "Flower_compositions"))
        
        databaseObject = NSManagedObject(entity: entity, insertInto: managedContext)
        databaseObject!.setValue(id + 1, forKey: "id")
        databaseObject!.setValue(amount, forKey: "amount")
        databaseObject!.setValue(cost, forKey: "cost")
        databaseObject!.setValue(composition_name, forKey: "composition_name")
        databaseObject!.setValue(kind, forKey: "kind")
        databaseObject!.setValue(name, forKey: "name")
        //let newImage = UIImage.jpegData(image)
        //databaseObject!.setValue(newImage, forKey: "image")
        
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
    
    func kind() -> String?
    {
        return databaseObject?.value(forKey: "kind") as? String
    }
    
    func name() -> String?
    {
        return databaseObject?.value(forKey: "name") as? String
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
