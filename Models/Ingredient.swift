//
//  Ingredient.swift
//  SousChef
//
//  Created by Louis Trapani on 3/25/18.
//  Copyright © 2018 trapani. All rights reserved.
//

import Foundation

class Ingredient: NSObject {
    
    //stored properties
    var ingredientName: String = ""
    var ingredientType: String = ""
    override internal var description: String {
        return """
        {
        ingredientName: \(ingredientName)
        ingredientType: \(ingredientType)
        }
        """
    }
    
    func getIngredientName()->String{return ingredientName}
    func getIngredientType()->String{return ingredientType}
    func set(ingredientName:String) {self.ingredientName = ingredientName}
    func set(ingredientType:String) {self.ingredientType = ingredientType}
        
    init(ingredientName: String, ingredientType: String) {
        self.ingredientName = ingredientName
        self.ingredientType = ingredientType
    }
    
    var title : String? {
        get {
            return ingredientName
        }
    }
    
    var subtitle : String? {
        get {
            return ingredientType
        }
    }

}
