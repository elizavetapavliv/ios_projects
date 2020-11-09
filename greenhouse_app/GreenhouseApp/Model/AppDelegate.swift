//
//  AppDelegate.swift
//  GreenhouseApp
//
//  Created by Elizaveta on 5/31/19.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        if !UserDefaults.standard.bool(forKey: "HasLaunchedOnce")
        {
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
        
            var _: AuthorizationEntity = AuthorizationEntity(persistentContainer: persistentContainer, login: "user1", password: "111")
            var _: AuthorizationEntity = AuthorizationEntity(persistentContainer: persistentContainer, login: "user2", password: "222")
        
            var _: Flower_compositionsEntity = Flower_compositionsEntity(persistentContainer: persistentContainer, amount: 3, cost: 24, composition_name: "Composition1", kind: "Rose", name: "Noisette Rose")
            var _: Flower_compositionsEntity = Flower_compositionsEntity(persistentContainer: persistentContainer, amount: 1, cost: 10, composition_name: "Composition2", kind: "Tulip", name: "Attila")
            var _: Flower_compositionsEntity = Flower_compositionsEntity(persistentContainer: persistentContainer, amount: 21, cost: 24, composition_name: "Composition3", kind: "Rose", name: "Noisette Rose")
            var _: Flower_compositionsEntity = Flower_compositionsEntity(persistentContainer: persistentContainer, amount: 12, cost: 7, composition_name: "Composition3", kind: "Carnation", name: "Dianthus Barbatus")
        
            
            var _: CompositionsEntity = CompositionsEntity(persistentContainer: persistentContainer, amount: 3, cost: 72, composition_name: "Composition1")
            var _: CompositionsEntity = CompositionsEntity(persistentContainer: persistentContainer, amount: 1, cost: 10, composition_name: "Composition2")
            var _: CompositionsEntity = CompositionsEntity(persistentContainer: persistentContainer, amount: 33, cost: 588, composition_name: "Composition3")
            
            var _: OrdersEntity = OrdersEntity(persistentContainer: persistentContainer, user_id: 1, amount: 1, cost: 372, flower_composition: "Composition1", login: "user1")
            var _: OrdersEntity = OrdersEntity(persistentContainer: persistentContainer, user_id: 2, amount: 1, cost: 72, flower_composition: "Composition1", login: "user2")
            var _: OrdersEntity = OrdersEntity(persistentContainer: persistentContainer, user_id: 2, amount: 3, cost: 30, flower_composition: "Composition2", login: "user2")
            
        }
        
        
//        var applicationDocumentsDirectory: NSURL = {
//            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            return urls[urls.count-1] as NSURL
//        }()
//        print(applicationDocumentsDirectory )
//        
        return true
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
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "GreenhouseApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

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

