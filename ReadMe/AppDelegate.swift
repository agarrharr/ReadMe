//
//  AppDelegate.swift
//  ReadMe
//
//  Created by Adam Garrett-Harris on 8/27/21.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Books")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unable to load persistent stores: \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
}
