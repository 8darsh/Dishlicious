//
//  detailRecipesViewController.swift
//  Dishlicious
//
//  Created by Adarsh Singh on 09/10/23.
//

import UIKit

class detailRecipesViewController: UIViewController {
    
    @IBOutlet var dishImages: UIImageView!
    
    @IBOutlet var ingredients: UILabel!
    
    @IBOutlet var dietryFibres: UILabel!
    
    var dish: Recipes?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDetails()
        
    }
    
    func setDetails(){
        
        self.dishImages.setImage(with: dish?.image ?? "hehe")
        self.dishImages.layer.cornerRadius = 12
        for ingredient in dish?.ingredientLines ?? []{
            
            self.ingredients.text! += "\(ingredient) \n "
            
        }
        for dietry in dish?.healthLabels ?? []{
            
            self.dietryFibres.text! += "\(dietry), "
        }
    }
    



}
