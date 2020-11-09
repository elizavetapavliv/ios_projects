//
//  AppDelegate.swift
//  task2.2
//
//  Created by Elizaveta on 5/13/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
        
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSManagedObjectModel.mergedModel(from: nil)
        return modelURL!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("races.sqlite")
        do
        {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        }
        catch {
            NSLog("Unresolved error")
            abort()
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedContext.persistentStoreCoordinator = coordinator
        return managedContext
    }()
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do
            {
                try managedObjectContext.save()
            }
            catch
            {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if !UserDefaults.standard.bool(forKey: "HasLaunchedOnce")
        {
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
            
            let entity = NSEntityDescription.entity(forEntityName: "Record", in: self.managedObjectContext)
            let record1 = Record(entity: entity!, insertInto: self.managedObjectContext)
            let record2 = Record(entity: entity!, insertInto: self.managedObjectContext)
            let record3 = Record(entity: entity!, insertInto: self.managedObjectContext)
            
            record1.busStation = "Bus station \"Tushinckaya\""
            record1.setValue(true, forKey: "availability")
            record1.cityFrom = "Moscow"
            record1.cityTo = "Tallinn"
            record1.setValue(104.0, forKey:"price")
            
            record2.busStation = "Bus station \"Orehovo\""
            record2.setValue(false, forKey: "availability")
            record2.cityFrom = "Moscow"
            record2.cityTo = "Tallinn"
            record2.setValue(115.2, forKey:"price")
            
            record3.busStation = "Central bus station"
            record3.setValue(true, forKey: "availability")
            record3.cityFrom = "Minsk"
            record3.cityTo = "Vilnius"
            record3.setValue(81.8, forKey: "price")
            
            self.saveContext()
        }
        return true
    }
    
    func getAllRaces() -> [Record]
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Record")
        var races = [NSManagedObject]()
        do
        {
            races = try managedObjectContext.fetch(fetchRequest)
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error)")
        }
        return races as! [Record]
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
          self.saveContext()
    }


}

