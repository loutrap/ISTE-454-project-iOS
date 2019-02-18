//
//  RecipesTVC.swift
//  SousChef
//
//  Created by Louis Trapani on 4/4/18.
//  Copyright © 2018 trapani. All rights reserved.
//

import UIKit

class ShoppingListTVC: UITableViewController {
    let testData:[String] = ["Test1", "Test2","Test3","Test4"]
    var shoppingArray : [String] = NSMutableArray() as! [String]
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingArray = defaults.stringArray(forKey: "shoppingList") ?? [String]()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        shoppingArray = defaults.stringArray(forKey: "shoppingList") ?? [String]()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItemCell", for: indexPath)
        
        let ingredient = shoppingArray[indexPath.row]
        cell.textLabel?.text = ingredient
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            shoppingArray.remove(at: indexPath.row)
            UserDefaults.standard.set(shoppingArray, forKey: "shoppingList")
            tableView.reloadData()
        }
    }    
}

