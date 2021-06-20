//
//  BeerCell.swift
//  HoldMyBeer
//
//  Created by Ignacio Lopez Jimenez on 18/6/21.
//

import UIKit

//Custom cell for the list of Beers used in ListViewController
class BeerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
