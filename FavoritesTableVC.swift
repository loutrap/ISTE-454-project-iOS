//
//  FavoritesTableVC.swift
//  SousChef
//
//  Created by Louis Trapani on 5/5/18.
//  Copyright © 2018 trapani. All rights reserved.
//

import UIKit

class FavoritesTableVC: UITableViewController {
    var recipeList = Recipes()
    let defaults = UserDefaults.standard
    var myarray : [String] = NSMutableArray() as! [String]
    var idArray : [String] = NSMutableArray() as! [String]

    var recipes : [Recipe] {
        get {
            return self.recipeList.recipeList
        }
        set(val) {
            self.recipeList.recipeList = val
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myarray = defaults.stringArray(forKey: "favorites") ?? [String]()
        idArray = defaults.stringArray(forKey: "favoritesID") ?? [String]()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myarray = defaults.stringArray(forKey: "favorites") ?? [String]()
        idArray = defaults.stringArray(forKey: "favoritesID") ?? [String]()
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
        return myarray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
        let recipe = myarray[indexPath.row]
        cell.textLabel?.text = recipe
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = myarray[indexPath.row]
        let recipeID = idArray[indexPath.row]
        var selectedRecipe:Recipe!
        for r in recipeList.recipeList {
            if (r.getRecipeName() == recipe) {
                selectedRecipe = r
            }
        }
        let detailVC = RecipesDetailTVC(style: .grouped)
        detailVC.recipe = selectedRecipe
        detailVC.favID = recipeID
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            myarray.remove(at: indexPath.row)
            idArray.remove(at: indexPath.row)
            UserDefaults.standard.set(myarray, forKey: "favorites")
            UserDefaults.standard.set(myarray, forKey: "favoritesID")
            tableView.reloadData()
        }
    }
}
