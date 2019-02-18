//
//  AppDelegate.swift
//  SousChef
//
//  Created by Louis Trapani on 3/24/18.
//  Copyright © 2018 trapani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var ingredients:[Ingredient] = []
    var vegetables:[Ingredient] = []
    var fruits:[Ingredient] = []
    var meats:[Ingredient] = []
    var bakery:[Ingredient] = []
    var dairy:[Ingredient] = []
    var condiments:[Ingredient] = []
    var spricesSeasonings:[Ingredient] = []

    var tabBarController:UITabBarController?


    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // API 
        var request = URLRequest(url: URL(string: "http://example.com")!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            print("Entered the completionHandler")
            }.resume()
        
        loadData()
        
        tabBarController = window?.rootViewController as? UITabBarController
        //let mainVC = tabBarController!.viewControllers![0] as! MainVC
        let navVC = tabBarController!.viewControllers![0] as! UINavigationController
        let mainVC = navVC.viewControllers[0] as! MainVC
        let ingredientList = Ingredients()
        let vegetableList = Ingredients()
        let fruitList = Ingredients()
        let meatList = Ingredients()
        let dairyList = Ingredients()
        let bakeryList = Ingredients()
        let condimentList = Ingredients()
        let spiceSeasoningList = Ingredients()
        //ingredientList.ingredientsList = ingredients
        vegetableList.vegetablesList = vegetables
        fruitList.fruitsList = fruits
        meatList.meatsList = meats
        dairyList.dairyList = dairy
        bakeryList.bakeryList = bakery
        condimentList.condimentsList = condiments
        spiceSeasoningList.spicesList = spricesSeasonings
        //mainVC.ingredientsList = ingredientList.ingredientsList
        mainVC.vegetablesList = vegetableList.vegetablesList
        mainVC.fruitsList = fruitList.fruitsList
        mainVC.meatsList = meatList.meatsList
        mainVC.dairyList = dairyList.dairyList
        mainVC.bakeryList = bakeryList.bakeryList
        mainVC.condimentsList = condimentList.condimentsList
        mainVC.spicesList = spiceSeasoningList.spicesList
        
        return true
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "ingredients", ofType: "plist") {
            if let tempDict = NSDictionary(contentsOfFile: path) {
                let tempArray = (tempDict.value(forKey: "Ingredients") as! NSArray) as Array
                for dict in tempArray {
                    if dict["type"]! as! String == "Vegetable" {
                        let name = dict["name"]! as! String
                        let type = dict["type"]! as! String
                        let ing = Ingredient(ingredientName: name, ingredientType: type)
                        vegetables.append(ing)
                    } else if dict["type"]! as! String == "Fruit" {
                        let name = dict["name"]! as! String
                        let type = dict["type"]! as! String
                        let ing = Ingredient(ingredientName: name, ingredientType: type)
                        fruits.append(ing)
                    } else if dict["type"]! as! String == "Meat" {
                        let name = dict["name"]! as! String
                        let type = dict["type"]! as! String
                        let ing = Ingredient(ingredientName: name, ingredientType: type)
                        meats.append(ing)
                    } else if dict["type"]! as! String == "Dairy" {
                        let name = dict["name"]! as! String
                        let type = dict["type"]! as! String
                        let ing = Ingredient(ingredientName: name, ingredientType: type)
                        dairy.append(ing)
                    } else if dict["type"]! as! String == "Bakery" {
                        let name = dict["name"]! as! String
                        let type = dict["type"]! as! String
                        let ing = Ingredient(ingredientName: name, ingredientType: type)
                        bakery.append(ing)
                    } else if dict["type"]! as! String == "Condiment" {
                        let name = dict["name"]! as! String
                        let type = dict["type"]! as! String
                        let ing = Ingredient(ingredientName: name, ingredientType: type)
                        condiments.append(ing)
                    } else if dict["type"]! as! String == "Spice/Seasoning" {
                        let name = dict["name"]! as! String
                        let type = dict["type"]! as! String
                        let ing = Ingredient(ingredientName: name, ingredientType: type)
                        spricesSeasonings.append(ing)
                    }
                }
            }
        }
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
    }


}

