//
//  DishModel.swift
//  Dishlicious
//
//  Created by Adarsh Singh on 09/10/23.
//

import Foundation

struct DishModel: Codable{
    var hits:[RecipesAccess]
}
struct RecipesAccess:Codable{
    var recipe: Recipes
}
struct Recipes: Codable{
    var label: String
    var image: String
    var dietLabels: [String]?
    var healthLabels:[String]
    var ingredientLines:[String]
    var calories:Double?
    var cuisineType:[String]?
    var mealType: [String]
    
}
