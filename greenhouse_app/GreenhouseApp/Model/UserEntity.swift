//
//  UserEntity.swift
//  GreenhouseApp
//
//  Created by Lizaveta Rudzko on 3/15/1398 AP.
//

import Foundation
import CoreData

class UserEntity
{
    private var databaseObject: NSManagedObject?
    
    init(persistentContainer: NSPersistentContainer, login: String)
    {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let id = try! managedContext.count(for: NSFetchRequest(entityName: "User"))
        
        databaseObject = NSManagedObject(entity: entity, insertInto: managedContext)
        databaseObject!.setValue(id + 1, forKey: "id")
        databaseObject!.setValue(login, forKey: "login")

        
        try! managedContext.save()
    }
    
    func id_by_login(persistentContainer: NSPersistentContainer, login: String) -> Int32?
    {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "login = %@", login)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        
        if objects.count > 0
        {
            var tempObj: NSManagedObject?
            tempObj = objects[0]
            return tempObj?.value(forKey: "id") as? Int32
        } else {
            return -1
        }
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
    
    func login() -> String?
    {
        return databaseObject?.value(forKey: "login") as? String
    }
    
}
