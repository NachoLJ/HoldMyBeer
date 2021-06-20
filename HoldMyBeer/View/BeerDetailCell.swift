//
//  BeerDetailCell.swift
//  HoldMyBeer
//
//  Created by Ignacio Lopez Jimenez on 19/6/21.
//

import UIKit

//Custom cell for the details of the beer selected used in DetailsViewController
class BeerDetailCell: UITableViewCell {

    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var brewerTipLabel: UILabel!
    @IBOutlet weak var foodPairingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
