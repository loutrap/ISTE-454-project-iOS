//
//  MainVC.swift
//  SousChef
//
//  Created by Louis Trapani on 3/25/18.
//  Copyright © 2018 trapani. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {
    @IBAction func recipeSearch(_ sender: UIButton) {

    }
    @IBOutlet weak var dataTable: UITableView!
    var ingredient:Ingredient!
    var selectedIngredients = Ingredients()
    var vegetables = Ingredients()
    var fruits = Ingredients()
    var meats = Ingredients()
    var dairy = Ingredients()
    var bakery = Ingredients()
    var condiments = Ingredients()
    var spicesSeasonings = Ingredients()
    var shoppingList = Ingredients()
    var ingredientLocation = [String: Int]();


    
    var responseData: Data?
    var urlString = ""
    var xmlParser = XMLParser()
    var itemArray:[String] = []


    var selectedIngredientsList : [String] {
        get {
            return self.selectedIngredients.selectedIngredientsList
        }
        set(val) {
            self.selectedIngredients.selectedIngredientsList = val
        }
    }
    
    var vegetablesList : [Ingredient] {
        get {
            return self.vegetables.vegetablesList
        } set(val) {
            self.vegetables.vegetablesList = val
        }
    }
    var fruitsList : [Ingredient] {
        get {
            return self.fruits.fruitsList
        } set(val) {
            self.fruits.fruitsList = val
        }
    }
    var meatsList : [Ingredient] {
        get {
            return self.meats.meatsList
        } set(val) {
            self.meats.meatsList = val
        }
    }
    var dairyList : [Ingredient] {
        get {
            return self.dairy.dairyList
        } set(val) {
            self.dairy.dairyList = val
        }
    }
    var bakeryList : [Ingredient] {
        get {
            return self.bakery.bakeryList
        } set(val) {
            self.bakery.bakeryList = val
        }
    }
    var condimentsList : [Ingredient] {
        get {
            return self.condiments.condimentsList
        } set(val) {
            self.condiments.condimentsList = val
        }
    }
    var spicesList : [Ingredient] {
        get {
            return self.spicesSeasonings.spicesList
        } set(val) {
            self.spicesSeasonings.spicesList = val
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dataTable.reloadData()
        selectedIngredients = Ingredients()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataTable.delegate = self
        self.dataTable.dataSource = self
        dataTable.estimatedRowHeight = 44.0
        dataTable.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
            if (section == 0) {
                return "Vegetables"
            } else if (section == 1) {
                return "Fruits"
            } else if (section == 2) {
                return "Meats"
            } else if (section == 3) {
                return "Dairy"
            } else if (section == 4) {
                return "Bakery"
            } else if (section == 5) {
                return "Spices/Seasonings"
            } else if (section == 6) {
                return "Condiments"
            } else {
                return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return vegetablesList.count
        } else if section == 1 {
            return fruitsList.count
        } else if section == 2 {
            return meatsList.count
        } else if section == 3 {
            return dairyList.count
        } else if section == 4 {
            return bakeryList.count
        } else if section == 5 {
            return spicesList.count
        } else if section == 6 {
            return condimentsList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        
            if (indexPath.section == 0) {
                for _ in 0..<vegetablesList.count {
                    vegetablesList = vegetablesList.sorted{$0.getIngredientName() < $1.getIngredientName()}
                    let ingredient = vegetablesList[indexPath.row]
                    cell.textLabel?.text = ingredient.ingredientName
                    cell.editingAccessoryType = .checkmark
                }
            } else if (indexPath.section == 1) {
                fruitsList = fruitsList.sorted{$0.getIngredientName() < $1.getIngredientName()}
                for _ in 0..<fruitsList.count {
                    let ingredient = fruitsList[indexPath.row]
                    cell.textLabel?.text = ingredient.ingredientName
                }
            } else if (indexPath.section == 2) {
                meatsList = meatsList.sorted{$0.getIngredientName() < $1.getIngredientName()}
                for _ in 0..<meatsList.count {
                    let ingredient = meatsList[indexPath.row]
                    cell.textLabel?.text = ingredient.ingredientName
                }
            } else if (indexPath.section == 3) {
                dairyList = dairyList.sorted{$0.getIngredientName() < $1.getIngredientName()}
                for _ in 0..<dairyList.count {
                    let ingredient = dairyList[indexPath.row]
                    cell.textLabel?.text = ingredient.ingredientName
                }
            } else if (indexPath.section == 4) {
                bakeryList = bakeryList.sorted{$0.getIngredientName() < $1.getIngredientName()}
                for _ in 0..<bakeryList.count {
                    let ingredient = bakeryList[indexPath.row]
                    cell.textLabel?.text = ingredient.ingredientName
                }
            } else if (indexPath.section == 5) {
                spicesList = spicesList.sorted{$0.getIngredientName() < $1.getIngredientName()}
                for _ in 0..<spicesList.count {
                    let ingredient = spicesList[indexPath.row]
                    cell.textLabel?.text = ingredient.ingredientName
                }
            } else if (indexPath.section == 6) {
                condimentsList = condimentsList.sorted{$0.getIngredientName() < $1.getIngredientName()}
                for _ in 0..<condimentsList.count {
                    let ingredient = condimentsList[indexPath.row]
                    cell.textLabel?.text = ingredient.ingredientName
                }
            }

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            selectedIngredientsList.append((cell.textLabel?.text)!)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {

        if let i = selectedIngredientsList.index(of: (cell.textLabel?.text)!) {
            print("THIS IS I: \(i)")
            selectedIngredientsList.remove(at: i)
        }
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let addItem = UITableViewRowAction(style: .normal, title: "Add to List") { action, index in
            var itemName = (tableView.cellForRow(at: editActionsForRowAt)?.textLabel?.text)!
            var groceryItem = UserDefaults.standard.array(forKey: "shoppingList") as? [String]
            if groceryItem != nil {
                
                if !groceryItem!.contains(itemName) {
                    groceryItem!.append(itemName)
                }
            } else {
                groceryItem = []
            }
            let alert = UIAlertController(title: "Grocery List", message: "\(itemName) has been added to your Favorites", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
            self.present(alert,animated: true)
            UserDefaults.standard.set(groceryItem, forKey:"shoppingList")
            
        }
        addItem.backgroundColor = .green
        return [addItem]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (selectedIngredientsList.isEmpty || selectedIngredientsList.count <= 1) {
            let alert = UIAlertController(title: "Invalid", message: "You must select at least two ingredients before proceeding", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
            self.present(alert,animated: true)
        } else {
            if segue.destination is RecipesTVC
            {
                let vc = segue.destination as? RecipesTVC
                vc?.receivedIngredients = selectedIngredientsList
            }
        }
    }
}
