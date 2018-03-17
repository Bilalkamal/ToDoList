//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Bilal on 2018-03-12.
//  Copyright © 2018 Bilal Kamal Co. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
     

        do {
            _ = try Realm()
          
        }catch {
            print("Error initializing realm : \(error)")
        }
        
        return true
    }


   
}



