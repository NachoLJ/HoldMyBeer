//
//  ListViewController.swift
//  HoldMyBeer
//
//  Created by Ignacio Lopez Jimenez on 15/6/21.
//

import UIKit

//This class runs the API request of the BeerManager and show the result in a TableView
class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var beerManager = BeerManager()
    var foodNameValue = "";
    var beers: [BeerData] = []
    var beerSelected: BeerData? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        beerManager.delegate = self
        
        //Register BeerCell
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        //call the data request from BeerManager with the food as parameter
        getBeerData(foodName: foodNameValue)
    }
    
    
    @IBAction func mostABVButton(_ sender: UIButton) {
        descABV()
    }
    
    @IBAction func lessABVButton(_ sender: UIButton) {
        ascABV()
    }
    func getBeerData(foodName: String) {
        DispatchQueue.global(qos: .userInitiated).async{
            self.beerManager.fetchBeer(foodName: foodName)
        }
    }
    
    //Sort the array of beers in ascending abv order
    func ascABV(){
        self.beers.sort {$0.abv < $1.abv}
        tableView.reloadData()
    }
    
    //Sort the array of beers in descending abv order
    func descABV(){
        self.beers.sort {$0.abv > $1.abv}
        tableView.reloadData()
    }
    
    //prepare the segue setting one selected beer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.beer = beerSelected
            
            
        }
    }
    
}

//MARK: - BeerManagerDelegate
//Defining the protocol functionality
extension ListViewController: BeerManagerDelegate {
    //Store the data requested in a variable, sort it and unhide the tableview
    func didUpdateBeers(_ beerManager: BeerManager, beerList: [BeerData]) {
        DispatchQueue.main.async {
            self.beers = beerList
            self.ascABV()
            self.tableView.isHidden = false
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    
}

//MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    //Return the number of rows in the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    //Set the cell for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! BeerCell
        
        cell.nameLabel.text = beers[indexPath.row].name
        cell.abvLabel.text = "ABV: \(String(format: "%.1f", beers[indexPath.row].abv))%"
        return cell
    }
}

//Control what to do when a cell is selected
//Perform the segue to the DetailsView and store the data of the row selected in a variable
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        beerSelected = beers[indexPath.row]
        self.performSegue(withIdentifier: "goToDetails", sender: self)
    }
}
