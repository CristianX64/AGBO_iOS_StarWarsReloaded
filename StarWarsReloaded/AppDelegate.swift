//
//  AppDelegate.swift
//  StarWarsReloaded
//
//  Created by David de Tena on 12/05/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

        // Star Wars universe
        var starWarsUniverseModel = DTCStarWarsUniverse()
        var starWarsUniverseVC = DTCStarWarsUniverseViewController(model: starWarsUniverseModel)
        
        
        // First character to be displayed is the first in _imperials Array
        // It will be the delegate for UISplitView
        var characterVC = DTCCharacterViewController(model: starWarsUniverseModel._imperials[0])
        
        
        // Combiners
        var universeNavVC = UINavigationController(rootViewController: starWarsUniverseVC)
        var characterNavVC = UINavigationController(rootViewController: characterVC)
        var splitVC = UISplitViewController()
        splitVC.viewControllers = [universeNavVC,characterNavVC]
        
        // Delegates
        splitVC.delegate = characterVC
        starWarsUniverseVC.delegate = characterVC
        
        // SplitVC will be the rootVC in the app
        self.window?.rootViewController = splitVC
        
        // Override point for customization after application launch.
        //self.window!.backgroundColor = UIColor.redColor()
        
        self.window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    
    // MARK: - Utils
    
    func initModel(){
        
    }
    
}

