//
//  BeerManager.swift
//  HoldMyBeer
//
//  Created by Ignacio Lopez Jimenez on 17/6/21.
//

import Foundation

//Defining the Protocol needs
protocol BeerManagerDelegate {
    func didUpdateBeers(_ beerManager: BeerManager, beerList: [BeerData])
    func didFailWithError(error: Error)
}

struct BeerManager {
    
    let userDefaults = UserDefaults.standard
    let beerURL = "https://api.punkapi.com/v2/beers"
    var delegate: BeerManagerDelegate?
    
    func fetchBeer (foodName: String) {
        
        //userDefaults to store data with food name as key
        let storedData = userDefaults.data(forKey: foodName)
        
        //Check if there is data stored
        //If there is data, parse that data and store in a vatiable via delegate
        //If not, perform a request to the API
        if storedData != nil {
            do{
                let decodedData = try JSONDecoder().decode([BeerData].self, from: storedData!)
                delegate?.didUpdateBeers(self, beerList: decodedData)
                
            } catch {
                delegate?.didFailWithError(error: error)
            }
            
        } else {
            let urlString = "\(beerURL)?food=\(foodName)"
            performRequest(with: urlString, foodName: foodName)
        }
    }
    
    //Perform request to the API
    func performRequest(with urlString: String, foodName: String) {
        //Create a URL
        if let url = URL(string: urlString) {
            //Create a URLSession
            let session = URLSession(configuration: .default)
            //Give the session a Task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                //Parse and Store the requested data in a variable
                //Also Store the requested data in UserDefauls
                if let safeData = data {
                    if let beerList = self.parseJSON(safeData) {
                        UserDefaults.standard.set(data, forKey: foodName)
                        delegate?.didUpdateBeers(self, beerList: beerList)
                    }
                }
            }
            //Start the Task
            task.resume()
        }
    }
    
    //Decode the requested data
    func parseJSON(_ data: Data) -> [BeerData]? {
        do{
            let decodedData = try JSONDecoder().decode([BeerData].self, from: data)
            return decodedData
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
