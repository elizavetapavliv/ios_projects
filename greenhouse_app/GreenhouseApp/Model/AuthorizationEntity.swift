//
//  AuthorizationEntity.swift
//  GreenhouseApp
//
//  Created by Lizaveta Rudzko on 3/15/1398 AP.
//

import Foundation
import CoreData

class AuthorizationEntity
{
    private var databaseObject: NSManagedObject?
    
    init(persistentContainer: NSPersistentContainer, login: String) // ??
    {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Authorization")
        request.predicate = NSPredicate(format: "login = %@", login) // ??
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        
        if objects.count > 0
        {
            self.databaseObject = objects[0]
        } else {
            self.databaseObject = nil
        }
    }
    
    init(persistentContainer: NSPersistentContainer, login: String, password: String)
    {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Authorization", in: managedContext)!
        let id = try! managedContext.count(for: NSFetchRequest(entityName: "Authorization"))
        
        databaseObject = NSManagedObject(entity: entity, insertInto: managedContext)
        databaseObject!.setValue(id + 1, forKey: "user_id")
        databaseObject!.setValue(login, forKey: "login")
        databaseObject!.setValue(password, forKey: "password")
        
        try! managedContext.save()
    }
    
    func delete(persistentContainer: NSPersistentContainer)
    {
        persistentContainer.viewContext.delete(databaseObject!)
        try! persistentContainer.viewContext.save()
    }
    
    func user_id() -> Int32?
    {
        return databaseObject?.value(forKey: "user_id") as? Int32
    }
    
    func login() -> String?
    {
        return databaseObject?.value(forKey: "login") as? String
    }
    
    func password() -> String?
    {
        return databaseObject?.value(forKey: "password") as? String
    }
    
}
