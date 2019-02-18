//
//  RecipesTVC.swift
//  SousChef
//
//  Created by Louis Trapani on 4/4/18.
//  Copyright © 2018 trapani. All rights reserved.
//

import UIKit

class RecipesTVC: UITableViewController {
    let testData:[String] = ["Test1", "Test2","Test3","Test4"]
    var receivedIngredients:[String] = []

    //yummly
    let yummlyEndpoint = "http://api.yummly.com/v1/api/recipes?_app_id=9fa276e4&_app_key=9be5f69faaed205574f31c80aa948274"
    var ingredientsString = "&allowedIngredient[]="
    let getRecipe = "http://api.yummly.com/v1/api/recipe/Honey-Drizzled-Brie-with-Blueberries_-Walnuts-and-Basil-2399734?_app_id=9fa276e4&_app_key=9be5f69faaed205574f31c80aa948274"
    
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
        APICall()
    }
    
    func APICall() {
        urlString += yummlyEndpoint + ingredientsString + (receivedIngredients[0]).lowercased().replacingOccurrences(of: " ", with: "+")
        for i in 1...receivedIngredients.count-1 {
            let newString = (receivedIngredients[i]).lowercased().replacingOccurrences(of: " ", with: "+")
            urlString += "&allowedIngredient[]=\(newString)"
        }
        // Override point for customization after application launch.
        let endpoint = URL(string: urlString)
        let data = try? Data(contentsOf: endpoint!)
        
        //using swiftyJSON
        let session = URLSession.shared
        let loadDataTask = session.dataTask(with: endpoint!) {(data:Data?,response:URLResponse?,error:Error?) in
            if error != nil {
                //error occured...display an alert or seomthing
                //reminder - probably on backgroun thread at this point.
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.trapani.louis",code:httpResponse.statusCode,userInfo:[NSLocalizedDescriptionKey:"HTTP Status code has unexpected value"])
                } else {
                    
                    let json = try! JSON(data:data!) //do catch would be better
                    if let recipeName = json["matches"][0]["recipeName"].string {
                        //get list of recipes
                        if let recipeArray = json["matches"].array {
                            for recipeDict in recipeArray {
                                let recipeName:String? = recipeDict["recipeName"].string
                                let id:String? = recipeDict["id"].string
                                let totalTimeInSeconds:Int? = recipeDict["totalTimeInSeconds"].int
                                let rating:Int? = recipeDict["rating"].int
                                let recipe = Recipe()
                                recipe.setRecipeName(name: recipeName!)
                                recipe.setId(id: id!)
                                if totalTimeInSeconds != nil {
                                    recipe.setTotalTimeInSeconds(time: totalTimeInSeconds!)
                                } else {
                                    recipe.setTotalTimeInSeconds(time: 0)

                                }
                                recipe.setRating(rating: rating!)
                                self.recipes.append(recipe)
                            }
                            DispatchQueue.main.async(execute: {
                                self.tableView.reloadData()
                            })
                        }
                    }
                }
            }
        }
        loadDataTask.resume()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.getRecipeName()
        if (recipe.getTotalTimeInSeconds() != 0) {
            cell.detailTextLabel?.text = "Total Time: \(String(recipe.getTotalTimeInSeconds() / 60)) minutes | Rating: \(String(recipe.getRating()))/5"
        } else {
            cell.detailTextLabel?.text = "Total Time: N/A | Rating: \(String(recipe.getRating()))/5"

        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        let detailVC = RecipesDetailTVC(style: .grouped)
        detailVC.title = recipe.getRecipeName()
        detailVC.recipe = recipe
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
