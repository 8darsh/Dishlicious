//
//  RecipeTableViewCell.swift
//  Dishlicious
//
//  Created by Adarsh Singh on 13/10/23.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet var dishImage: UIImageView!
    
    @IBOutlet var dishName: UILabel!
    
    @IBOutlet var cuisineType: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
