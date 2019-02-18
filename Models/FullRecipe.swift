//
//  FullRecipe.swift
//  SousChef
//
//  Created by Louis Trapani on 3/25/18.
//  Copyright © 2018 trapani. All rights reserved.
//

import Foundation


class FullRecipe {
    
    //stored properties
    private var recipeName: String = ""
    private var id: String = ""
    private var ingredients: [String] = []
    private var prepTime: String = ""
    private var imageUrls: String = ""
    private var rating: Int = 0
    private var servings: String = ""
    private var sourceLink: String = ""
    
    public func getRecipeName() -> String {
        return self.recipeName
    }
    public func getId() -> String {
        return self.id
    }
    public func getIngredients() -> [String] {
        return self.ingredients
    }
    public func getPrepTime() -> String {
        return self.prepTime
    }
    public func getImageUrls() -> String {
        return self.imageUrls
    }
    public func getRating() -> Int {
        return self.rating
    }
    public func getServings() -> String {
        return self.servings
    }
    public func getSourceLink() -> String {
        return self.sourceLink
    }
    
    
    public func setRecipeName(name:String) {
        self.recipeName = name
    }
    public func setId(id:String) {
        self.id = id
    }
    public func setIngredients(ingredients:[String]) {
        self.ingredients = ingredients
    }
    public func setPrepTime(time:String) {
        self.prepTime = time
    }
    
    public func setImageUrls(imageUrls:String) {
        self.imageUrls = imageUrls
    }
    public func setRating(rating:Int) {
        self.rating = rating
    }
    public func setServings(servings:String) {
        self.servings = servings
    }
    public func setSourceLink(link:String) {
        self.sourceLink = link
    }
    
    
    init(){}
    init(json: [String:Any]) {        
        if let n = json["name"] as? String {
            recipeName = n
        }
        if let i = json["id"] as? String {
            id = i
        }
        if let pt = json["totalTime"] as? String {
            prepTime = pt
        }
        if let ingreds = json["ingredientLines"] as? [String] {
            ingredients = ingreds
        }
        
        if let img = json["images"] as? [[String:Any]] {
            for imgs in img {
                if(imgs["hostedLargeUrl"] as? String != nil) {
                    imageUrls = (imgs["hostedLargeUrl"] as? String)!
                } else {
                    imageUrls = "http://via.placeholder.com/350x150"
                }
            }
        }
        
        if let r = json["rating"] as? Int {
            rating = r
        }
        if let yield = json["yield"] as? String {
            servings = yield
        }
        if let src = json["source"] as? [String : String]  {
            sourceLink = src["sourceRecipeUrl"]!
        }

    }    
}

