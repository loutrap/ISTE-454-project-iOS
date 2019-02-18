//
//  Recipe.swift
//  SousChef
//
//  Created by Louis Trapani on 3/25/18.
//  Copyright © 2018 trapani. All rights reserved.
//

import Foundation

class Recipe {
    
    //stored properties
    private var recipeName: String = ""
    private var id: String = " "
    private var ingredients: [String] = []
    private var totalTimeInSeconds: Int = 0
    private var rating: Int = 0

    
    public func getRecipeName() -> String {
        return self.recipeName
    }
    public func getId() -> String {
        return self.id
    }
    public func getIngredients() -> [String] {
        return self.ingredients
    }
    public func getTotalTimeInSeconds() -> Int {
        return self.totalTimeInSeconds
    }
    public func getRating() -> Int {
        return self.rating
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
    public func setTotalTimeInSeconds(time:Int) {
        self.totalTimeInSeconds = time
    }
    
    public func setRating(rating:Int) {
        self.rating = rating
    }
    init(){}
}
