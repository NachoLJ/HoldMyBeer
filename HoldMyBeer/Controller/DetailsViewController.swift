//
//  DetailsViewController.swift
//  HoldMyBeer
//
//  Created by Ignacio Lopez Jimenez on 15/6/21.
//

import UIKit

//This class shows the details of the beer selected
class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    
    
    var beer: BeerData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        //Register the BeerDetailCell cell
        tableView.register(UINib(nibName: K.detailCellNibName, bundle: nil), forCellReuseIdentifier: K.detailCellIdentifier)
        nameLabel.text = beer!.name
        abvLabel.text = "ABV: \(String(format: "%.1f", beer!.abv))%"
        beerImage.image = downloadImage(url: beer?.image_url)
        
        //Set the tableview to automatically set his height when there is too much text
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    //Function that transforms the url of an image into a UIImage
    func downloadImage (url: String?) -> UIImage? {
        let imagePlaceHolder = "placeholder_beer.png"
        
        if let urlValue = URL(string: url ?? "") {
            let data = try? Data(contentsOf: urlValue)
            
            if let imageData = data {
                return UIImage(data: imageData)
            } else {
                return UIImage(named: imagePlaceHolder)
            }
        }
        return UIImage(named: imagePlaceHolder)
    }
    
}

//MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    
    //Return the number of rows in the tableview, in this case it will only be one.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //Set the cell contect
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.detailCellIdentifier, for: indexPath) as! BeerDetailCell
        
        if let beerSafe = beer {
            cell.tagLineLabel.text = beerSafe.tagline
            cell.descriptionLabel.text = beerSafe.description
            cell.brewerTipLabel.text = beerSafe.brewers_tips
            //Format the food pairing array into a user friendly format
            var formatedStringFood = ""
            for foodPair in beerSafe.food_pairing{
                formatedStringFood += "\t-\(foodPair)\n"
            }
            cell.foodPairingLabel.text = formatedStringFood
        }
        return cell
    }
    
    
}
