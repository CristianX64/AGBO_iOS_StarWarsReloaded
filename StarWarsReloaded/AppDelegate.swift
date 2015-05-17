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
        
        // Custom UI
        customizeAppearance()
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

        // Star Wars universe
        var starWarsUniverseModel = DTCStarWarsUniverse()
        
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad){
            // Configure for pads
            configureForPadWithModel(starWarsUniverseModel)
        }
        else{
            // Configure for phones
            configureForPhoneWithModel(starWarsUniverseModel)
        }
        
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


    
    // MARK: - Settings
    
    // Pad models
    func configureForPadWithModel(model: DTCStarWarsUniverse){
        
        var starWarsUniverseVC = DTCStarWarsUniverseViewController(model: model)
        
        // First character to be displayed is the first in _imperials Array
        // It will be the delegate for UISplitView
        var lastCharacter:DTCStarWarsCharacter = lastSelectedCharacterInUniverse(model)
        var characterVC = DTCCharacterViewController(model: lastCharacter)
        
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
    }
    
    // Phone models => table auto-delegate
    func configureForPhoneWithModel(model: DTCStarWarsUniverse){
        
        var starWarsUniverseVC = DTCStarWarsUniverseViewController(model: model)
        var universeNavVC = UINavigationController(rootViewController: starWarsUniverseVC)
        
        starWarsUniverseVC.delegate = starWarsUniverseVC
        
        // Table with characters will be the rootVC
        self.window?.rootViewController = universeNavVC
    }
    
    // Get the last selected character that was saved to NSUserDefaults
    func lastSelectedCharacterInUniverse(universe: DTCStarWarsUniverse) -> DTCStarWarsCharacter{

        var defaults = NSUserDefaults.standardUserDefaults()
        var section = defaults.integerForKey(lastCharacterSection)
        var row = defaults.integerForKey(lastCharacterRow)
        
        if(section == imperialSection){
            var character = universe.imperialAtIndex(row)
            return character
        }
        else{
            var character = universe.rebelAtIndex(row)
            return character
        }
    }
    
    // Custom UI
    func customizeAppearance(){

        // Custom colors
        var darkOrangeColor = UIColor(red: 233.0/255.0, green: 154.0/255.0, blue: 50.0/255.0, alpha: 1)
        var lightOrangeColor = UIColor(red: 255.0/255.0, green: 210.0/255.0, blue: 150.0/255.0, alpha: 1)
        var whiteColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
        var lightGrayColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1)
        var darkGrayColor = UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1)
        
        
        // Shadow for the Navigation title
        var titleShadow = NSShadow();
        titleShadow.shadowColor = darkGrayColor;
        titleShadow.shadowOffset = CGSizeMake(1, 1)
        
        // Background and font for headers and footers of tables
        UITableViewHeaderFooterView.appearance().tintColor = lightOrangeColor
        UILabel.appearance().font = UIFont(name: "Avenir", size: 16)
        UIToolbar.appearance().barTintColor = lightOrangeColor
        UIToolbar.appearance().tintColor = darkOrangeColor
        UINavigationBar.appearance().barTintColor = darkOrangeColor
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().tintColor = darkGrayColor
        
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad){
            
            var font:UIFont? = UIFont(name: "Starjedi", size: 20)
            if let jediFont = font{
                var barTextAttributes:NSDictionary = NSDictionary(objectsAndKeys: jediFont,NSFontAttributeName, whiteColor, NSForegroundColorAttributeName, titleShadow, NSShadowAttributeName)
                UINavigationBar.appearance().titleTextAttributes = barTextAttributes as [NSObject : AnyObject]
            }
        }
        else{
            var font:UIFont? = UIFont(name: "Starjedi", size: 14)
            if let jediFont = font{
                var barTextAttributes:NSDictionary = NSDictionary(objectsAndKeys: jediFont,NSFontAttributeName, whiteColor, NSForegroundColorAttributeName, titleShadow, NSShadowAttributeName)
                UINavigationBar.appearance().titleTextAttributes = barTextAttributes as [NSObject : AnyObject]
            }
        }
    }
    
}

