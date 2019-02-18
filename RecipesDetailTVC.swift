//
//  RecipesDetailTVC.swift
//  SousChef
//
//  Created by Louis Trapani on 4/24/18.
//  Copyright © 2018 trapani. All rights reserved.
//

import UIKit

class RecipesDetailTVC: UITableViewController {
    var recipe:Recipe!
    var favID:String!
    var urlID:String!
    var fullRecipe:FullRecipe!
    let RECIPE_INFO = 0
    let RECIPE_INGREDIENTS = 1
    let RECIPE_STEPS = 2
    let RECIPE_FAV = 3
    
    var receivedIngredients:[String] = []

    var getRecipeURL = ""
    var urlString = ""
    var responseData: Data?
    var recipeList = Recipes()
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
        
        if favID != nil {
            urlID = favID
        } else {
            urlID = self.recipe.getId()
        }
        getRecipeURL = "http://api.yummly.com/v1/api/recipe/\(urlID!)?_app_id=9fa276e4&_app_key=9be5f69faaed205574f31c80aa948274"
        APICall()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func APICall() {
        let endpoint = URL(string: getRecipeURL)
        let data = try? Data(contentsOf: endpoint!)

        if let json = (try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as? [String:Any] {
            var fullRecipe = FullRecipe(json: json)
            self.fullRecipe = FullRecipe(json: json)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        DispatchQueue.main.async(execute: {
            tableView.backgroundColor = self.UIColorFromRGB(rgbValue: 0xD9F3E8)
        })
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case RECIPE_INFO:
            return 3
        case RECIPE_INGREDIENTS:
            return fullRecipe.getIngredients().count
        case RECIPE_STEPS:
            return 1
        case RECIPE_FAV:
            return 1
        default:
            break
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == RECIPE_INFO {
            if indexPath.row == 2 {
                return 200.0
            }
        } else {
            return 44.0
        }
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "recDetailCell")
        
        cell?.imageView?.image = nil

        DispatchQueue.main.async(execute: {
            cell?.backgroundColor = self.UIColorFromRGB(rgbValue: 0xD9F3E8)
        })

        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "recDetailCell")
        }
        
        cell?.textLabel?.textAlignment = .center
        switch indexPath.section {
        case RECIPE_INFO:
            if indexPath.row == 0 {
                cell?.textLabel?.text = "Total Time: " + fullRecipe.getPrepTime()
            } else if indexPath.row == 1 {
                cell?.textLabel?.text = "Rating: \(String(fullRecipe.getRating()))/5"
            } else if indexPath.row == 2 {
                let url = URL(string: fullRecipe.getImageUrls())
                
                if url != nil {
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        DispatchQueue.main.async {
                            cell?.imageView?.image = UIImage(data: data!)
                            cell?.layoutSubviews()
                        }
                    }
                }
            }
            
        case RECIPE_INGREDIENTS:
            for _ in 0..<fullRecipe.getIngredients().count {
                let ingredient = fullRecipe.getIngredients()[indexPath.row]
                cell?.textLabel?.text = ingredient
            }
        case RECIPE_STEPS:
            cell?.textLabel?.text = "Read Directions"
            DispatchQueue.main.async(execute: {
                cell?.backgroundColor = self.UIColorFromRGB(rgbValue: 0x628FCD)
            })
            
        case RECIPE_FAV:
            cell?.textLabel?.text = "Add to Favorites"
            DispatchQueue.main.async(execute: {
                cell?.backgroundColor = self.UIColorFromRGB(rgbValue: 0x628FCD)
            })
        default:
            break
        }
        
        return cell!
    }
    
    
    // helper function for converting color
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        switch indexPath.section {
        case RECIPE_STEPS:
            if let url = URL(string: fullRecipe.getSourceLink()){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case RECIPE_FAV:            
            var favorites = UserDefaults.standard.array(forKey: "favorites") as? [String]
            var favoritesID = UserDefaults.standard.array(forKey: "favoritesID") as? [String]
            
            if favorites != nil {
                if !favorites!.contains(fullRecipe.getRecipeName()) {
                    favorites!.append(fullRecipe.getRecipeName())
                }
            } else {
                favorites = []
            }
            
            if favoritesID != nil {
                if !favoritesID!.contains(fullRecipe.getId()) {
                    favoritesID!.append(fullRecipe.getId())
                } else {
                    let alert = UIAlertController(title: "Favorites", message: "\(fullRecipe.getRecipeName()) is already in your Favorites", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(OKAction)
                    present(alert,animated: true)
                }
            } else {
                favoritesID = []
            }
            
            let alert = UIAlertController(title: "Favorites", message: "\(fullRecipe.getRecipeName()) has been added to your Favorites", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
            present(alert,animated: true)
            
            
            UserDefaults.standard.set(favorites, forKey:"favorites")
            UserDefaults.standard.set(favoritesID, forKey:"favoritesID")

        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        
        switch section {
        case RECIPE_INFO:
            title = ""
        case RECIPE_INGREDIENTS:
            title = "List of Ingredients"
        case RECIPE_STEPS:
            title = ""
        case RECIPE_FAV:
            title = ""
        default:
            break
        }
        return title
    }
}
