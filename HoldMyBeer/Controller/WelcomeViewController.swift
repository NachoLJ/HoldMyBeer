//
//  ViewController.swift
//  HoldMyBeer
//
//  Created by Ignacio Lopez Jimenez on 15/6/21.
//

import UIKit

class WelcomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var foodFormated = ""
    
    var listVC = ListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        
        //Animation for the String in the Welcome screen
        messageLabel.text = ""
        var charIndex = 0.0 // para aumentar progresivamente el Intervalo del Timer
        let messageText = K.Strings.messageString
        for letter in messageText {
            //Timer simulating tipping
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.messageLabel.text?.append(letter)
            }
            charIndex += 1
        }
        
    }
    
    //Function managing the search button
    //When end writting, the keyboard is dismissed
    //Lauch the segue and check if the textField is empty
    @IBAction func searchButton(_ sender: UIButton) {
        searchTextField.endEditing(true)
        if searchTextField.text != "" {
            self.performSegue(withIdentifier: "goToList", sender: self)
        } else {
            searchTextField.placeholder = "Type something"
        }
    }
    
    //Function managing the Return button of the keyboad
    //When end writting, the keyboard is dismissed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    //Return the food written and formate it in the correct format for the API request.
    func getFoodText() -> String {
        if let food = searchTextField.text {
            return  food.replacingOccurrences(of: " ", with: "_")
        }
        return ""
    }
    
    //Prepare the next screen sending the food value written by the user
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToList" {
            let destinationVC = segue.destination as! ListViewController
            destinationVC.foodNameValue = getFoodText()
        }
    }
}

